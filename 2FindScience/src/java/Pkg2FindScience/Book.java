/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Book extends Document{
    private String cdrom;
    private int volume;
    private String month;
    private String isbn;

    /**
     * @return the cdrom
     */
    public String getCdrom() {
        return cdrom;
    }

    /**
     * @param cdrom the cdrom to set
     */
    public void setCdrom(String cdrom) {
        this.cdrom = cdrom;
    }

    /**
     * @return the volume
     */
    public int getVolume() {
        return volume;
    }

    /**
     * @param volume the volume to set
     */
    public void setVolume(int volume) {
        this.volume = volume;
    }

    /**
     * @return the month
     */
    public String getMonth() {
        return month;
    }

    /**
     * @param month the month to set
     */
    public void setMonth(String month) {
        this.month = month;
    }

    /**
     * @return the isbn
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * @param isbn the isbn to set
     */
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

}
