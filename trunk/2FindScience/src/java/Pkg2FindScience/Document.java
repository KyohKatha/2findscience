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

    public Document(){

    }
    
    public Document(String title, String insertion, String url, String ee, String type){
        super(title, insertion, url, type);
        this.ee = ee;

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
