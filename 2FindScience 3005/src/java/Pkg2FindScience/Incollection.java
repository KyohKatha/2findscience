/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Incollection extends Document{
    private int chapter;
    private int startPage;
    private int endPage;
    private String cdrom;
    private String isbn;

    /**
     * @return the chapter
     */
    public int getChapter() {
        return chapter;
    }

    /**
     * @param chapter the chapter to set
     */
    public void setChapter(int chapter) {
        this.chapter = chapter;
    }

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
