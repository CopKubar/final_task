package com.kubar.itransition.dao;

import com.kubar.itransition.model.Step;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@SuppressWarnings("unchecked")
public class BookDao {

    @Autowired
    private LocalContainerEntityManagerFactoryBean entityManagerFactoryBean;

    @Transactional
    public void indexBooks() throws Exception
    {
        try
        {
            EntityManager em = entityManagerFactoryBean.getNativeEntityManagerFactory().createEntityManager();
            FullTextEntityManager fullTextEntityManager =
                    org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
            em.getTransaction().begin();
            fullTextEntityManager.createIndexer().startAndWait();
            em.getTransaction().commit();
            em.close();
        }
        catch(Exception e)
        {
            throw e;
        }
    }


    @Transactional
    public List<Step> searchForBook(String searchText) throws Exception {
        try {
            System.out.println("searchForBook");
            EntityManager em = entityManagerFactoryBean.getNativeEntityManagerFactory().createEntityManager();
            FullTextEntityManager fullTextEntityManager =
                    org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
            em.getTransaction().begin();

            QueryBuilder qb = fullTextEntityManager.getSearchFactory()
                    .buildQueryBuilder().forEntity(Step.class).get();

            org.apache.lucene.search.Query luceneQuery = qb
                    .keyword()
                    .onFields("name", "description", "instruction.title","comments.text")
                    .matching(searchText)
                    .createQuery();

            javax.persistence.Query jpaQuery =
                    fullTextEntityManager.createFullTextQuery(luceneQuery, Step.class);

            List<Step> result = jpaQuery.getResultList();
            System.out.println();
            em.getTransaction().commit();
            em.close();
            for (Step step: result){
                if (step==null){
                    System.out.println("ничего не найдено");
                }else {
                    System.out.println(step.getName());
                }
            }
            return result;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }


}
