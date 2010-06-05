/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;
import java.sql.Timestamp;

/**
 *
 * @author Welington
 */
public class Post {
    private double cod;
    private String user;
    private Timestamp date;
    private String text;

    /**
     * @return the cod
     */
    public double  getCod() {
        return cod;
    }

    /**
     * @param cod the cod to set
     */
    public void setCod(double cod) {
        this.cod = cod;
    }

    /**
     * @return the user
     */
    public String getUser() {
        return user;
    }

    /**
     * @param user the user to set
     */
    public void setUser(String user) {
        this.user = user;
    }

    /**
     * @return the date
     */
    public Timestamp getDate() {
        return date;
    }

    /**
     * @param date the date to set
     */
    public void setDate(Timestamp date) {
        this.date = date;
    }

    /**
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }
}
