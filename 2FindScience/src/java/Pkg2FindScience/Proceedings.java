/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Proceedings extends ResearchReport{
    private String address;
    private String isbn;
    private String publisher;
    private String editor;

    public Proceedings(String title, String url, String ee, String journal, String volume,
            String number, String note, String month, String address, String editor, String author,
            String publisher, String bookTitle, String isbn, double cod) {

        super(title, url, ee, journal, volume, number, note, month, "proceedings", author, bookTitle, cod);
        this.address = address;
        this.isbn = isbn;
        this.publisher = publisher;
        this.editor = editor;

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
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
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
