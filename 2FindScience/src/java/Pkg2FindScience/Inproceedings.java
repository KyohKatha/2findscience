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
    private String startPage;
    private String endPage;
    private String cdrom;
    private String note;
    private String number;
    private String month;
    private String publisher;
    private String editor;
    private String bookTitle;

    public Inproceedings(String title, String url, String ee, String startPage, String endPage, String cdrom, String note,
            String number, String month, String author,String bookTitle, String publisher, String editor, double cod) {
        super(title, url, ee, "inproceedings", author, null, cod);

        this.startPage = startPage;
        this.endPage = endPage;
        this.cdrom = cdrom;
        this.note = note;
        this.number = number;
        this.month = month;
        this.publisher = publisher;
        this.editor = editor;
        this.bookTitle = bookTitle;
    }

    public String getEditor() {
        return editor;
    }

    public void setBookTitle(String bookTitle){
        this.bookTitle = bookTitle;
    }

    public String getBookTitle(){
        return this.bookTitle;
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
    public String getNumber() {
        return number;
    }

    /**
     * @param number the number to set
     */
    public void setNumber(String number) {
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
