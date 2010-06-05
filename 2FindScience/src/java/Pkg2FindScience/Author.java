/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Pkg2FindScience;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Welington
 */
public class Author {
    private long cod;
    private String name;

    /**
     * @return the cod
     */
    public long getCod() {
        return cod;
    }

    /**
     * @param cod the cod to set
     */
    public void setCod(long cod) {
        this.cod = cod;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = this.removeSpaces(name);
    }

    public String getNameForView() {
        String parts[] = this.name.split("\\s");
        String formattedName = "";

        switch (parts.length) {
            case 0:
                formattedName = "";
                break;
            case 1:
                formattedName = this.name;
                break;
            default:
                int i = 0;

                do {
                    formattedName += " " + parts[i].trim();
                    i++;
                } while (i < parts.length - 1);

                formattedName = "<b>" + parts[parts.length - 1] + "</b>," + formattedName;
        }

        return formattedName.trim();
    }

    private String removeSpaces(String name) {
        String padrao = "\\s{2,}";
        Pattern regPat = Pattern.compile(padrao);
        Matcher matcher = regPat.matcher(name);
        String res = matcher.replaceAll(" ").trim();
        return res;
    }
}

