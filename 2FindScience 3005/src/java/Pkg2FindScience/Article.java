/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Pkg2FindScience;

/**
 *
 * @author Welington
 */
public class Article extends ResearchReport {

    private String cdrom;
    private String startPage;
    private String endPage;

    public Article(String title, String insertion, String url, String ee, String journal, String volume,
            String note, String number, String month, String cdrom, String startPage, String endPage) {

        super(title, insertion, url, ee, journal, volume, number, note, month, "article");
        this.cdrom = cdrom;
        this.endPage = endPage;
        this.startPage = startPage;
        
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
}
