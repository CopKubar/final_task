package com.kubar.itransition.controller;

import com.kubar.itransition.dao.BookDao;
import com.kubar.itransition.dao.InstructionDao;
import com.kubar.itransition.dto.UserDetailsDto;
import com.kubar.itransition.model.Category;
import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Step;
import com.kubar.itransition.model.User;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView showStartPage() throws Exception {
        //bookDao.indexBooks();
        for (Category category: categoryService.getAll()){
            System.out.println(category.getName());
        }
        return new ModelAndView("index","categories",categoryService.getAll());
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView AddInstruction(  ) {
        ModelAndView modelAndView=new ModelAndView("/profile");
        modelAndView.addObject("categories", categoryService.getAll());
        return modelAndView;
    }


    @RequestMapping(value = "/addInstruction", method = RequestMethod.POST)
    public ModelAndView AddInstruction(@RequestParam String title,@RequestParam String youtubeUrl,@RequestParam String category) {
        System.out.println(title);
        System.out.println(youtubeUrl);
        System.out.println(category);
        UserDetailsDto userDetailsDto =(UserDetailsDto) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Instruction instruction = new Instruction();
        instruction.setTitle(title);
        instruction.setYoutubeUrl(youtubeUrl);
        instruction.setUser(userService.findById(userDetailsDto.getId()));
        instruction.setCategory(categoryService.findByName(category));
        Instruction instruction1 = instructionService.save(instruction);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("addStep");
        mav.addObject("categories", getAllCategories());
        mav.addObject("instruction", instruction1);
        return mav;
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
        System.out.println("/controller/register");
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
    public ModelAndView search(
            @RequestParam("searchText")
                    String searchText
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

    private List<Category> getAllCategories(){
        return categoryService.getAll();
    }

}
