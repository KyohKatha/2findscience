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

    private int type;  // 1 : booktitle, 0: publication
    private String date;
    private String name;

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

}