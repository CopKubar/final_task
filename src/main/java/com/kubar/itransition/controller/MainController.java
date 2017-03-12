package com.kubar.itransition.controller;

import com.kubar.itransition.dto.UserDetailsDto;
import com.kubar.itransition.model.*;
import com.kubar.itransition.utilities.forModels.InstructionUtil;
import com.kubar.itransition.utilities.forModels.StepUtil;
import com.kubar.itransition.utilities.security.SecurityUtil;
import com.kubar.itransition.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.web.ProviderSignInUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;

@Controller
public class MainController {

    private UserService userService;

    private UsersConnectionRepository usersConnectionRepository;

    private ConnectionFactoryLocator connectionFactoryLocator;

    private SecurityUtil securityUtil;

    private CategoryService categoryService;

    private InstructionService instructionService;

    private LikeService likeService;

    private StepService stepService;

    private StepUtil stepUtil;

    private CommentService commentService;

    private InstructionUtil instructionUtil;

    @Autowired
    public MainController(UserService userService, UsersConnectionRepository usersConnectionRepository, ConnectionFactoryLocator connectionFactoryLocator, SecurityUtil securityUtil, CategoryService categoryService, InstructionService instructionService, LikeService likeService, StepService stepService, StepUtil stepUtil, CommentService commentService, InstructionUtil instructionUtil) {
        this.userService = userService;
        this.usersConnectionRepository = usersConnectionRepository;
        this.connectionFactoryLocator = connectionFactoryLocator;
        this.securityUtil = securityUtil;
        this.categoryService = categoryService;
        this.instructionService = instructionService;
        this.likeService = likeService;
        this.stepService = stepService;
        this.stepUtil = stepUtil;
        this.commentService = commentService;
        this.instructionUtil = instructionUtil;
    }

    @RequestMapping(value = {"/","/index"}, method = RequestMethod.GET)
    public ModelAndView showStartPage() throws Exception {
        ModelAndView modelAndView = new ModelAndView("index","categories",categoryService.getAll());
        if (!SecurityContextHolder.getContext().getAuthentication().getName().equals("anonymousUser")){
            modelAndView.addObject("user", securityUtil.getUserFromContext());
        }
        modelAndView.addObject("popularInstructions", instructionUtil.get12MostPopularInstruction(instructionService.findAll()));
        modelAndView.addObject("newInstructions", instructionUtil.get12MostNewestInstruction(instructionService.findAll()));
        return modelAndView;
    }

    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied(){
        return new ModelAndView("error404");
    }

    @RequestMapping(value = "/ban/user/{userId}", method = RequestMethod.POST)
    public ModelAndView banUser(@PathVariable String userId){
        userService.setBanToUser(userService.findById(userId));
        return new ModelAndView(new RedirectView("/profile/"+userId));
    }

    @RequestMapping(value = "/set/admin/{userId}", method = RequestMethod.POST)
    public ModelAndView setAdminRole(@PathVariable String userId){
        userService.setRoleAdminToUser(userService.findById(userId));
        return new ModelAndView(new RedirectView("/profile/"+userId));
    }

    @RequestMapping(value = "/profile/{userid}", method = RequestMethod.GET)
    public ModelAndView AddInstruction(@PathVariable String userid) {
        ModelAndView modelAndView=new ModelAndView("profile");
        modelAndView.addObject("categories", categoryService.getAll());
        modelAndView.addObject("user", userService.findById(userid));
        modelAndView.addObject("foreignAccount", securityUtil.isForeignAccount(userid));
        return modelAndView;
    }

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public ModelAndView redirectToRegistrationPage() {
        return new ModelAndView(new RedirectView("/user/register"));
    }

    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/user/register", method = RequestMethod.GET)
    public ModelAndView registrationUser(WebRequest web){
        Connection<?> connection = new ProviderSignInUtils(connectionFactoryLocator, usersConnectionRepository).getConnectionFromSession(web);
        User user = userService.registerNewUser(securityUtil.createRegistrationUser(connection));
        securityUtil.logInUser(user);
        new ProviderSignInUtils(connectionFactoryLocator, usersConnectionRepository).doPostSignUp(user.getId(), web);
        return new ModelAndView(new RedirectView("/"));
    }

    @RequestMapping(value = "/doSearch", method = RequestMethod.GET)
    public ModelAndView search(@RequestParam("searchText") String searchText
    ) throws Exception
    {
        try {
            System.out.println("Зашел");
            List<Step> allFound = stepService.searchLucene(searchText);

            System.out.println("Найдено "+allFound.size()+" записей");

            ModelAndView mav = new ModelAndView("searchOutput", "foundBooks", instructionUtil.getInstructionSearch(stepService.searchLucene(searchText)));
            return mav;
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return null;
    }

    @RequestMapping(value = "/addInstruction", method = RequestMethod.POST)
    public ModelAndView AddInstruction(@RequestParam String title,@RequestParam String youtubeUrl,
                                 @RequestParam String category,@RequestParam String image ) {
        System.out.println(title);
        System.out.println(youtubeUrl);
        System.out.println(category);
        System.out.println(image);
        UserDetailsDto userDetailsDto =(UserDetailsDto) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Instruction instruction = new Instruction();
        instruction.setTitle(title);
        instruction.setYoutubeUrl(youtubeUrl);
        instruction.setCategory(categoryService.findByName(category));
        instruction.setImageUrl(image);
        instruction.setUser(userService.findById(userDetailsDto.getId()));
        System.out.println("дошло");
        try{
            instructionService.save(instruction);
            stepService.indexSteps();
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return new ModelAndView("addStep","instruction",instruction);
    }

    @RequestMapping(value = "/regroup", method = RequestMethod.POST)
    @ResponseBody
    public void regroupStepList(@RequestParam Long stepId,@RequestParam Integer newPosition) {
        stepUtil.changePositions(stepId, newPosition);
    }

    @RequestMapping(value = "/editStep", method = RequestMethod.POST)
    @ResponseBody
    public String addOrEditStep(@RequestParam Long id, @RequestParam Long instruction_id, @RequestParam String title,
                            @RequestParam String description, @RequestParam String img) throws Exception {
        String response="";
//TODO check user permission
        Step step=new Step();
        Instruction instruction=instructionService.findById(instruction_id);
        System.out.println(id);
        step.setId(id);
        step.setInstruction(instruction);
        step.setDescription(description);
        step.setImageUrl(img);
        step.setName(title);
        if (instruction.getSteps().size() == 0) {
                step.setPosition(0);
        }else {
            step.setPosition(instruction.getSteps().size());
        }
        stepService.save(step);
        response=response+"{\"step_id\" : "+step.getId()+"}";
        stepService.indexSteps();
        return response;
    }


        @RequestMapping(value = "/addcomment", method = RequestMethod.POST)
    public @ResponseBody
        HashMap<String, Object> processAJAXRequest(
            @RequestParam String text,
            @RequestParam String stepId) throws Exception {
            System.out.println("начало метода");
        Step step = stepService.findById(Long.parseLong(stepId));
        Comment comment = new Comment();
        comment.setStep(step);
        comment.setText(text);
        comment.setUser(securityUtil.getUserFromContext());
        commentService.save(comment);
        HashMap<String, Object> map = new HashMap<>();
        map.put("comment", text);
        map.put("username", comment.getUser().getName());
        map.put("userid", comment.getUser().getId());
        stepService.indexSteps();
        return map;
    }

    @RequestMapping(value = "/showinstruction/{instructionid}", method = RequestMethod.GET)
    public ModelAndView showInstructionPage(@PathVariable("instructionid") Long instructionId) throws Exception {
        Instruction instruction=instructionService.findById(instructionId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("instructionView");
        modelAndView.addObject("categories", categoryService.getAll());
        modelAndView.addObject("instruction", instruction);
        modelAndView.addObject("rating", likeService.findAllLikes(instruction.getLikes()));
        modelAndView.addObject("usersLikeState", likeService.getUsersStateLike(instruction.getUser(), instruction));
        modelAndView.addObject("user", instruction.getUser());
        modelAndView.addObject("category", instruction.getCategory());
        modelAndView.addObject("step", instruction.getSteps().get(0));
        modelAndView.addObject("numberOfSteps", instruction.getSteps().size());
        modelAndView.addObject("comments", instruction.getSteps().get(0).getComments());
        return modelAndView;
    }

    @RequestMapping(value = "/get_step", method = RequestMethod.POST)
    @ResponseBody
    public String getStep(@RequestParam Integer step_number, @RequestParam Long instruction_id) {
        Instruction instruction=instructionService.findById(instruction_id);
        Step step = stepUtil.getSortedListWithSteps(instruction.getSteps()).get(step_number);
        String response=stepUtil.generatedJson(step);
        return response;
    }
    @RequestMapping(value = "/like", method = RequestMethod.GET)
    @ResponseBody
    public void getLikeOrDislike(@RequestParam Long instructionId,@RequestParam int ratingValue) {
        System.out.println("в контроллере");
        Instruction instruction = instructionService.findById(instructionId);
        User user = securityUtil.getUserFromContext();
        likeService.changeRating(user, instruction, ratingValue);
    }

}
