/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Kaori
 */
public class News {
    private double cod;
    private int type;  // 1 : booktitle, 0: publication
    private String date;
    private String name;

    public News(double cod, int type, String date, String name){
        this.cod = cod;
        this.type = type;
        this.date = date;
        this.name = name;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDate() {
        return date;
    }

    public String getName() {
        return name;
    }

    public int getType() {
        return type;
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

}
