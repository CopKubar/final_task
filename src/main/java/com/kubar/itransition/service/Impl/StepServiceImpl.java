package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.StepDao;
import com.kubar.itransition.model.Step;
import com.kubar.itransition.service.StepService;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

@Service
@Transactional
public class StepServiceImpl implements StepService{

    @Autowired
    private StepDao stepDao;

    @Autowired
    private LocalContainerEntityManagerFactoryBean entityManagerFactoryBean;

    @Override
    public Step findById(Long id) {
        return stepDao.findById(id);
    }

    @Override
    public Step findByPosition(int position) {
        return stepDao.findByPosition(position);
    }

    @Override
    public void save(Step step) {
        stepDao.saveAndFlush(step);
    }

    @Override
    public void delete(Step step) {
        stepDao.delete(step);
    }

    @Override
    public void indexSteps() throws Exception {
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

    @Override
    public List<Step> searchLucene(String textSearch) throws Exception {
        try {
            EntityManager em = entityManagerFactoryBean.getNativeEntityManagerFactory().createEntityManager();
            FullTextEntityManager fullTextEntityManager =
                    org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
            em.getTransaction().begin();

            QueryBuilder qb = fullTextEntityManager.getSearchFactory()
                    .buildQueryBuilder().forEntity(Step.class).get();

            org.apache.lucene.search.Query luceneQuery = qb
                    .keyword()
                    .onFields("name", "description", "instruction.title", "comments.text")
                    .matching(textSearch)
                    .createQuery();

            javax.persistence.Query jpaQuery =
                    fullTextEntityManager.createFullTextQuery(luceneQuery, Step.class);

            List<Step> result = jpaQuery.getResultList();
            System.out.println();
            em.getTransaction().commit();
            em.close();
            return result;
        } catch (Exception e) {
            return null;
        }
    }
}
