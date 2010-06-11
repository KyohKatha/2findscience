/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

public class User {
    private String login;
    private String password;
    private String name;
    private String email;
    private String page;
    private int profile;
    private int upgrade;
    private int numTrialUpgrade;
    private boolean haveSubjects;

    public User() {
        this.login = null;
        this.password = null;
        this.name = null;
        this.email = null;
        this.page = null;
        this.profile = -1;
        this.upgrade = -1;
        this.numTrialUpgrade = -1;
    }

    public User(String login, String password, String name, String email,
            String page, int profile, int upgrade, int numTrialUpgrade) {

        this.login = login;
        this.password = password;
        this.name = name;
        this.email = email;
        this.page = page;
        this.profile = profile;
        this.upgrade = upgrade;
        this.numTrialUpgrade = numTrialUpgrade;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public void setUpgrade(int upgrade) {
        this.upgrade = upgrade;
    }

    public void setNumTrialUpgrade(int numTrialUpgrade) {
        this.numTrialUpgrade = numTrialUpgrade;
    }

    public String getLogin() {
        return this.login;
    }

    public String getPassword() {
        return this.password;
    }

    public String getName() {
        return this.name;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPage() {
        return this.page;
    }

    public int getProfile() {
        return this.profile;
    }

    public int getUpgrade() {
        return this.upgrade;
    }

    public int getNumTrialUpgrade() {
        return this.numTrialUpgrade;
    }

    public boolean getHaveSubjects() {
        return haveSubjects;
    }

    public void setHaveSubjects(boolean haveSubjects) {
        this.haveSubjects = haveSubjects;
    }

}



