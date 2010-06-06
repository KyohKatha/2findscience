/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Www extends Document{
        private String note;
    private String publisher;
    private String editor;

    public Www(String title, String url, String ee, String note, String editor, String author, String publisher, String bookTitle, double cod) {

        super(title, url, ee, "www", author, bookTitle, cod);
        this.note = note;
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

}
