package com.kubar.itransition.controller;

import com.kubar.itransition.dao.BookDao;
import com.kubar.itransition.dto.UserDetailsDto;
import com.kubar.itransition.model.*;
import com.kubar.itransition.security.util.SecurityUtil;
import com.kubar.itransition.service.CategoryService;
import com.kubar.itransition.service.InstructionService;
import com.kubar.itransition.service.UserService;
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
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private UsersConnectionRepository usersConnectionRepository;

    @Autowired
    private ConnectionFactoryLocator connectionFactoryLocator;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private BookDao bookDao;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private InstructionService instructionService;

    @RequestMapping(value = {"/","/index"}, method = RequestMethod.GET)
    public ModelAndView showStartPage() throws Exception {
        //bookDao.indexBooks();
        ModelAndView modelAndView = new ModelAndView("index","categories",categoryService.getAll());
        if (!SecurityContextHolder.getContext().getAuthentication().getName().equals("anonymousUser")){
            modelAndView.addObject("user", securityUtil.getUserFromContext());
        }
        return modelAndView;
    }

    @RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
    public ModelAndView accessDenied(){
        return new ModelAndView("error404");
    }

    @RequestMapping(value = "/ban/user", method = RequestMethod.POST)
    public ModelAndView banUser(@RequestParam("userId")String userId){
        userService.setBanToUser(userService.findById(userId));
        return new ModelAndView(new RedirectView("/"));
    }

    @RequestMapping(value = "/profile/{userid}", method = RequestMethod.GET)
    public ModelAndView AddInstruction(@PathVariable String userid) {
        ModelAndView modelAndView=new ModelAndView("profile");
        modelAndView.addObject("categories", categoryService.getAll());
        modelAndView.addObject("user", userService.findById(userid));
        modelAndView.addObject("foreignAccount", isForeignAccount(userid));
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

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView searchPage() {
        System.out.println(securityUtil.getUserFromContext().getName()+" "+securityUtil.getUserFromContext().getId());
        ModelAndView mav = new ModelAndView("search");
        return mav;
    }

    @RequestMapping(value = "/doSearch", method = RequestMethod.GET)
    public ModelAndView search(@RequestParam("searchText") String searchText
    ) throws Exception
    {
        try {
            System.out.println("Зашел");
            List<Step> allFound = bookDao.searchForBook(searchText);

            System.out.println("Найдено "+allFound.size()+" записей");

            ModelAndView mav = new ModelAndView("foundBooks", "foundBooks", allFound.size());
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
        instructionService.save(instruction);
        return new ModelAndView("addStep","instruction",instruction);
    }
    @RequestMapping(value = "/editStep", method = RequestMethod.POST)
    @ResponseBody
    public void editStep( @RequestParam String id, @RequestParam String instruction_id, @RequestParam String title,
                          @RequestParam String description, @RequestParam String img) {
        System.out.println(title);
        System.out.println(id);
        System.out.println(instruction_id);
        System.out.println(description);
        System.out.println(img);
// UserDetailsDto userDetailsDto =(UserDetailsDto) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

// instructionRepository.save(new Instruction(title,youtubeUrl, userService.findById(userDetailsDto.getId()),categoryRepository.findOne(category)));
//return "hooray";
    }

    @RequestMapping(value = "/getAllUsers", method = RequestMethod.GET)
    public ModelAndView getAllUsers(){
        return new ModelAndView("users", "users", userService.findAll());
    }

    private List<Category> getAllCategories(){
        return categoryService.getAll();
    }

    private Boolean isForeignAccount(String userid){
        try {
            if (userid.equals(securityUtil.getUserFromContext().getId())){
                return false;
            }else {
                return true;
            }
        }catch (Exception e){
            return null;
        }

    }

}
