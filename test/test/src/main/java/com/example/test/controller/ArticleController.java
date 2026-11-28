package com.example.test.controller;

import com.example.test.dto.ArticleForm;
import com.example.test.entity.Article;
import com.example.test.repository.ArticleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Controller
public class ArticleController {
    @Autowired
    private ArticleRepository articleRepository;
    @GetMapping("/articles/new")
    public String newArticleForm(){
        return "articles/new";
    }

    @PostMapping("/articles/create")
    public String createArticle(ArticleForm form){
        //System.out.println(form.toString());
        log.info(form.toString());
        Article article = form.toEntity();
        //System.out.println(article.toString());
        log.info(article.toString());
        Article saved = articleRepository.save(article);
        //System.out.println(saved.toString());
        log.info(saved.toString());

        return "";
    }

    @GetMapping("/articles/{id}")
    public String show(@PathVariable Long id, Model model){
        log.info("id = " + id);
        //Optional<Article> articleEntity = articleRepository.findById(id);
        Article articleEntity = articleRepository.findById(id).orElse(null);
        model.addAttribute("article", articleEntity);
        return "articles/show";
    }

    @GetMapping("/articles")
    public String index(Model model){
        ArrayList<Article> articleEntityList = articleRepository.findAll();
        //List<Article> articleEntityList = (List<Article>)articleRepository.findAll();
        //Iterable<Article> articleEntityList = (List<Article>)articleRepository.findAll();
        model.addAttribute("articleList", articleEntityList);
        return "articles/index";
    }
}
