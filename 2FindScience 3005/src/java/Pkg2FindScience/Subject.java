/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Gustavo Henrique
 */
public class Subject {
    private int cod;
    private String name;


    public Subject(int cod, String name){
        this.cod = cod;
        this.name = name;
    }
    
    /**
     * @return the cod
     */
    public int getCod() {
        return cod;
    }

    /**
     * @param cod the cod to set
     */
    public void setCod(int cod) {
        this.cod = cod;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }




}
