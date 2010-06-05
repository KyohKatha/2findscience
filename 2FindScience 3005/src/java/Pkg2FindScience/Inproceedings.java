/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Inproceedings extends Document{
    private int startPage;
    private int endPage;
    private String cdrom;
    private String note;
    private int number;
    private String month;

    /**
     * @return the startPage
     */
    public int getStartPage() {
        return startPage;
    }

    /**
     * @param startPage the startPage to set
     */
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    /**
     * @return the endPage
     */
    public int getEndPage() {
        return endPage;
    }

    /**
     * @param endPage the endPage to set
     */
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

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
     * @return the note
     */
    public String getNote() {
        return note;
    }

    /**
     * @param note the note to set
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * @return the number
     */
    public int getNumber() {
        return number;
    }

    /**
     * @param number the number to set
     */
    public void setNumber(int number) {
        this.number = number;
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

}
