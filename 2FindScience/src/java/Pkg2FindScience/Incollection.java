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
    private String chapter;
    private String startPage;
    private String endPage;
    private String cdrom;
    private String isbn;
    private String publisher;
    private String editor;

    public Incollection(String title, String url, String ee, String startPage,
            String endPage, String cdrom, String chapter, String editor, String author,
            String publisher, String bookTitle, String isbn, double cod) {

        super(title, url, ee, "incollection", author, bookTitle, cod);
        this.chapter = chapter;
        this.startPage = startPage;
        this.endPage = endPage;
        this.editor = editor;
        this.cdrom = cdrom;
        this.isbn = isbn;
        this.publisher = publisher;

    }


    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    /**
     * @return the chapter
     */
    public String getChapter() {
        return chapter;
    }

    /**
     * @param chapter the chapter to set
     */
    public void setChapter(String chapter) {
        this.chapter = chapter;
    }

    /**
     * @return the startPage
     */
    public String getStartPage() {
        return startPage;
    }

    /**
     * @param startPage the startPage to set
     */
    public void setStartPage(String startPage) {
        this.startPage = startPage;
    }

    /**
     * @return the endPage
     */
    public String getEndPage() {
        return endPage;
    }

    /**
     * @param endPage the endPage to set
     */
    public void setEndPage(String endPage) {
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
