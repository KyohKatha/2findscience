/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Document extends Publication{
    private String ee;
    private String bookTitle;

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public Document(){

    }

    public Document(String title, String url, String ee, String type, String strAuthors, String bookTitle, double cod){
        super(title, url, type, strAuthors, cod);
        this.ee = ee;
        this.bookTitle = bookTitle;

    }

    /**
     * @return the ee
     */
    public String getEe() {
        return ee;
    }

    /**
     * @param ee the ee to set
     */
    public void setEe(String ee) {
        this.ee = ee;
    }
}
