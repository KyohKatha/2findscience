/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Thesis extends Publication{
    private String school;

    public Thesis(String title, String url, String school, String type, String strAuthor, double cod){
        super(title, url, type, strAuthor, cod);
        this.school = school;
    }

    /**
     * @return the school
     */
    public String getSchool() {
        return school;
    }

    /**
     * @param school the school to set
     */
    public void setSchool(String school) {
        this.school = school;
    }
}
