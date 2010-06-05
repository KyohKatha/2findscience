/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

import java.util.ArrayList;

/**
 *
 * @author Welington
 */
public class Publication {
    private String title;
    private String insertion;
    private String loginUser;
    private ArrayList<Author> authors;
    private String url;
    private String isbn;
    private String type;
    private double cod;
    private String journal;
    private ArrayList<Post> posts;

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public Publication(){
        
    }
    public Publication(String title, String insertion, String url, String type){
        this.title = title;
        this.insertion = insertion;
        this.url = url;
        this.type = type;
        
    }

    /**
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return the insertion
     */
    public String getInsertion() {
        return insertion;
    }

    /**
     * @param insertion the insertion to set
     */
    public void setInsertion(String insertion) {
        this.insertion = insertion;
    }

    /**
     * @return the idUser
     */
    public String getLoginUser() {
        return loginUser;
    }

    /**
     * @param idUser the idUser to set
     */
    public void setloginUser(String loginUser) {
        this.loginUser = loginUser;
    }

    /**
     * @return the authors
     */
    public ArrayList<Author> getAuthors() {
        return authors;
    }

    /**
     * @param authors the authors to set
     */
    public void setAuthors(ArrayList<Author> authors) {
        this.authors = authors;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the title
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * @param title the title to set
     */
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    /**
     * @param post the posts to be added to the forum
     */
    public void addAuthor(Author author) {
        if (this.authors == null)
            this.authors = new ArrayList<Author>();

        this.authors.add(author);
    }


    public ArrayList<Author> getAuthorsForView() {
        ArrayList<Author> temp = new ArrayList<Author>();
        for (int i = 0; i < this.authors.size(); i++) {
            Author author = this.authors.get(i);
            author.setName(author.getNameForView());
            temp.add(author);
        }

        return temp;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return the cod
     */
    public double getCod() {
        return cod;
    }

    /**
     * @param cod the cod to set
     */
    public void setCod(double cod) {
        this.cod = cod;
    }

    public ArrayList<Post> getPosts() {
        return posts;
    }

    public void setPosts(ArrayList<Post> posts) {
        this.posts = posts;
    }

    public void addPost(Post post) {
        if (this.posts == null)
            this.posts = new ArrayList<Post>();

        this.posts.add(post);
    }
}
