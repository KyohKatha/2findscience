package Pkg2FindScience;

import java.sql.*;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.util.ArrayList;
import java.util.Vector;

public class BDConnection {

    private static BDConnection instance = null;
    private Connection con;
    private Statement stm;
    private Statement stmTeste;

    public BDConnection() throws PublicationDAOException {
        try {
            SQLServerDataSource ds = new SQLServerDataSource();
            ds.setUser("317624");
            ds.setPassword("#gustavo123");
            ds.setDatabaseName("317624");

            //ds.setServerName("192.168.12.4");
            ds.setServerName("189.109.33.220");

            con = ds.getConnection();
            stm = con.createStatement();
            stmTeste = con.createStatement();
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public static BDConnection getInstance() throws PublicationDAOException {
        if (instance == null) {
            instance = new BDConnection();
        }
        return instance;
    }

    public ResultSet executeQuery(String sStatement) throws PublicationDAOException {
        ResultSet rs = null;
        try {
            stm.execute(sStatement);
            rs = stm.getResultSet();
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return rs;
    }

    public User login(String login, String password) throws PublicationDAOException {
        ResultSet rs = null;
        User user = new User();

        try {
            String sQuery = "SELECT name,email,profile,upgrade,numTrialUpgrade,page " + "FROM integrado.userData WHERE login = '" + login + "' AND password = '" + password + "';";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                int profile = rs.getInt("profile");
                int upgrade = rs.getInt("upgrade");
                int numTrialUpgrade = rs.getInt("numTrialUpgrade");
                String page = rs.getString("page");

                user.setLogin(login);
                user.setPassword(password);
                user.setName(name);
                user.setEmail(email);
                user.setProfile(profile);
                user.setUpgrade(upgrade);
                user.setNumTrialUpgrade(numTrialUpgrade);
                user.setPage(page);
            } else {
                System.out.print("Nenhum usuário");
                throw new PublicationDAOException();
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return user;
    }

    public Vector getSubjects() throws PublicationDAOException {
        Vector subjects = new Vector();
        ResultSet rs = null;
        Subject subject;

        try {
            String sQuery = "SELECT cod,subject FROM integrado.subject ORDER BY(subject);";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                int cod = rs.getInt("cod");
                String name = rs.getString("subject");
                subject = new Subject(cod, name);
                subjects.addElement(subject);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return subjects;
    }

    public Vector getSubjectsAvailable(Vector userSubjects) throws PublicationDAOException {
        Vector subjects = new Vector();
        ResultSet rs = null;
        Subject subject;

        try {
            String sQuery = "SELECT cod,subject FROM integrado.subject ORDER BY(subject);";
            stm.execute(sQuery);
            rs = stm.getResultSet();


            while (rs.next()) {
                int cod = rs.getInt("cod");
                String name = rs.getString("subject");

                boolean insert = true;

                for (int i = 0; i < userSubjects.size(); i++) {
                    Subject subjectsVector = (Subject) userSubjects.elementAt(i);

                    if (subjectsVector.getName().equals(name)) {
                        insert = false;
                    }
                }

                if (insert) {
                    subject = new Subject(cod, name);
                    subjects.addElement(subject);
                }
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return subjects;
    }

    public Vector getSubjectsUser(User user) throws PublicationDAOException {
        Vector subjects = new Vector();
        ResultSet rs = null;
        Subject subject;

        try {
            String sQuery = "SELECT cod, sub.subject FROM integrado.subject AS sub, integrado.userSubject AS usr " + "WHERE sub.cod = usr.codSubject AND usr.loginUser = '" + user.getLogin() + "' " + "ORDER BY(sub.subject);";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                int cod = rs.getInt("cod");
                String name = rs.getString("subject");
                subject = new Subject(cod, name);
                subjects.addElement(subject);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return subjects;
    }

    public void registerUser(User newUser, String subjects) throws PublicationDAOException {
        String[] vectorSubjects = subjects.split(";");
        ResultSet result = null;
        String sQuery = null;

        try {
            sQuery = "SELECT login FROM integrado.userData WHERE login='" + newUser.getLogin() + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                throw new PublicationDAOException("<p>-Error: <strong>Login</strong> already exists</p> <p>- Please enter another login</p>");
            }

        } catch (SQLException e) {
            throw new PublicationDAOException("<p>-Error: <strong>Login</strong> already exists</p> <p>- Please enter another login</p>");
        }


        try {
            sQuery = "INSERT INTO integrado.userData VALUES('" + newUser.getLogin() + "','" + newUser.getPassword() + "','" + newUser.getName() + "','" + newUser.getEmail() + "','" + newUser.getPage() + "',2,0,0);";
            stm.execute(sQuery);

            for (int i = 0; i < vectorSubjects.length; i++) {
                sQuery = "SELECT cod FROM integrado.subject WHERE subject= '" + vectorSubjects[i] + "';";
                stm.execute(sQuery);

                result = stm.getResultSet();

                if (result.next()) {
                    int cod = result.getInt("cod");
                    sQuery = "INSERT INTO integrado.userSubject VALUES('" + newUser.getLogin() + "'," + cod + ");";
                    stm.execute(sQuery);
                }
            }


        } catch (Exception e) {
            throw new PublicationDAOException("<p>- Error <strong>save</strong> data</p> <p>- Please try again</p>");
        }
    }

    public void updateUser(User currentUser, User newUser, String subjects) throws PublicationDAOException {
        String[] vectorSubjects = subjects.split(";");
        String sQuery = "UPDATE integrado.userData SET ";
        boolean update = false;

        try {
            if (!currentUser.getName().equals(newUser.getName())) {
                sQuery += "name = '" + newUser.getName() + "', ";
                update = true;
            }

            if (!currentUser.getEmail().equals(newUser.getEmail())) {
                sQuery += "email = '" + newUser.getEmail() + "', ";
            }

            if (!currentUser.getPage().equals(newUser.getPage())) {
                sQuery += "page = '" + newUser.getPage() + "', ";
                update = true;
            }

            if (!currentUser.getPassword().equals(newUser.getPassword())) {
                sQuery += "password = '" + newUser.getPassword() + "', ";
                update = true;
            }

            if (update) {
                sQuery = sQuery.substring(0, sQuery.length() - 2);
                sQuery += " WHERE login='" + currentUser.getLogin() + "'";
                stm.execute(sQuery);
            }

            sQuery = "DELETE FROM integrado.userSubject WHERE loginUser = '" + newUser.getLogin() + "';";
            stm.execute(sQuery);

            ResultSet result = null;

            for (int i = 0; i < vectorSubjects.length; i++) {
                sQuery = "SELECT cod FROM integrado.subject WHERE subject= '" + vectorSubjects[i] + "';";
                stm.execute(sQuery);

                result = stm.getResultSet();

                if (result.next()) {
                    int cod = result.getInt("cod");
                    sQuery = "INSERT INTO integrado.userSubject VALUES('" + newUser.getLogin() + "'," + cod + ");";
                    stm.execute(sQuery);
                }
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public Vector consultPublication(String sQuery) throws PublicationDAOException {
        Vector publications = new Vector();
        ResultSet rs = null;
        Publication publication;

        try {
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String title = rs.getString("title");
                String type = rs.getString("type");
                double cod = rs.getDouble("cod");
                publication = new Publication();
                publication.setTitle(title);
                publication.setType(type);
                publication.setCod(cod);
                publications.addElement(publication);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return publications;
    }

    public Article setArticle(Double codPublication) throws PublicationDAOException {
        Article article = null;
        ResultSet result = null;
        String sQuery = "SELECT * FROM view_article WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String insertion = result.getString("insertion");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String journal = result.getString("journal");
                String volume = result.getString("volume");
                String number = result.getString("number");
                String month = result.getString("month");
                String cdrom = result.getString("cdrom");
                String startPage = result.getString("startPage");
                String endPage = result.getString("endPage");
                String note = result.getString("note");

                article = new Article(title, insertion, url, ee, journal,
                        volume, note, number, month, cdrom, startPage, endPage);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return article;
    }

    public Vector getAuthors() throws PublicationDAOException {
        Vector authors = new Vector();
        ResultSet rs = null;

        try {
            String sQuery = "SELECT TOP 50 name FROM integrado.author ORDER BY name;";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String name = rs.getString("name");
                authors.addElement(name);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return authors;
    }

    public Vector getBookTitle() throws PublicationDAOException {
        Vector bookTitle = new Vector();
        ResultSet rs = null;

        try {
            String sQuery = "SELECT TOP 50 name FROM integrado.bookTitle ORDER BY cod;";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String name = rs.getString("name");
                bookTitle.addElement(name);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return bookTitle;
    }

    public void saveArticle(Article article, String login, String authors, String bookTitle) throws PublicationDAOException {
        String[] vectorAuthors = authors.split(";");

        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_article (?,?,?,?,?,?,?,?,?,?,?,?) }");
            st.setString("title", article.getTitle());

            if (article.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", article.getUrl());
            }

            if (article.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", article.getEe());
            }

            if (article.getJournal().equals("")) {
                st.setString("journal", null);
            } else {
                st.setString("journal", article.getJournal());
            }

            if (article.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setInt("volume", Integer.parseInt(article.getVolume()));
            }

            if (article.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setInt("number", Integer.parseInt(article.getNumber()));
            }

            if (article.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", article.getNote());
            }

            if (article.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", article.getMonth());
            }

            if (article.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", article.getCdrom());
            }

            if (article.getStartPage().equals("")) {
                st.setString("startPage", null);
            } else {
                st.setInt("startPage", Integer.parseInt(article.getStartPage()));
            }
            if (article.getEndPage().equals("")) {
                st.setString("endPage", null);
            } else {
                st.setInt("endPage", Integer.parseInt(article.getEndPage()));
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            sQuery = "SELECT cod FROM integrado.publication WHERE title='" + article.getTitle() + "' AND loginUser='" + login + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();
            double codPublication = -1;

            if (result.next()) {
                codPublication = result.getDouble("cod");

                for (int i = 0; i < vectorAuthors.length; i++) {
                    sQuery = "SELECT cod FROM integrado.author WHERE name like '" + this.formatField(vectorAuthors[i]) + "';";
                    stm.execute(sQuery);

                    result = stm.getResultSet();

                    if (result.next()) {
                        int cod = result.getInt("cod");
                        sQuery = "INSERT INTO integrado.authorPublication VALUES (" + codPublication + "," + cod + ");";
                    }
                }
            }

            if (!bookTitle.equals("")) {
                bookTitle = bookTitle.substring(0, bookTitle.length() - 1);
                sQuery = "SELECT cod FROM integrado.bookTitle WHERE name like '" + this.formatField(bookTitle) + "';";
                stm.execute(sQuery);
                ResultSet resultBook = stm.getResultSet();

                if (resultBook.next()) {
                    int cod = resultBook.getInt("cod");

                    sQuery = "UPDATE integrado.document SET codBookTitle = " + cod + " WHERE codPublication=" + codPublication + ";";
                    stm.execute(sQuery);
                }
            }
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    private String formatField(String field) {
        String result = "%";

        for (int i = 0; i < field.length(); i++) {
            if (field.charAt(i) == ' ') {
                result += '%';
            } else {
                result += field.charAt(i);
            }
        }

        result += '%';
        return result;
    }

    public void updateArticle(Article article, String login, String titleAnt) throws PublicationDAOException {

        String sQuery = "SELECT cod FROM integrado.publication WHERE title='" + titleAnt + "' AND loginUser='" + login + "' AND type='article';";
        ResultSet rs = null;

        try {
            stm.execute(sQuery);
            rs = stm.getResultSet();

            if (rs.next()) {
                double codPublication = rs.getDouble("cod");
                Article articleAnt = this.setArticle(codPublication);

                sQuery = "UPDATE integrado.publication SET ";
                boolean update = false;

                if (!article.getTitle().equals(articleAnt.getTitle())) {
                    sQuery += "title = '" + article.getTitle() + "', ";
                    update = true;
                }

                if (!article.getUrl().equals(articleAnt.getUrl())) {
                    sQuery += "url = '" + article.getUrl() + "', ";
                    update = true;
                }

                if (update) {

                    sQuery = sQuery.substring(0, sQuery.length() - 2);
                    sQuery += " WHERE loginUser='" + login + "' AND cod = " + codPublication + ";";
                    stm.execute(sQuery);
                }

                sQuery = "UPDATE integrado.document SET ";
                update = false;

                if (!article.getEe().equals(articleAnt.getEe())) {
                    sQuery += "ee = '" + article.getEe() + "', ";
                    sQuery = sQuery.substring(0, sQuery.length() - 2);
                    sQuery += " WHERE codpublication = " + codPublication + ";";
                    stm.execute(sQuery);
                }

                sQuery = "UPDATE integrado.researchreport SET ";
                update = false;

                if (!article.getJournal().equals(articleAnt.getJournal())) {
                    sQuery += "journal = '" + article.getJournal() + "', ";
                    update = true;
                }

                if (!article.getVolume().equals(articleAnt.getVolume())) {
                    sQuery += "volume = '" + article.getVolume() + "', ";
                    update = true;
                }

                if (!article.getNumber().equals(articleAnt.getNumber())) {
                    sQuery += "number = '" + article.getNumber() + "', ";
                    update = true;
                }
                if (!article.getNote().equals(articleAnt.getNote())) {
                    sQuery += "note = '" + article.getNote() + "', ";
                    update = true;
                }

                if (!article.getMonth().equals(articleAnt.getMonth())) {
                    sQuery += "month = '" + article.getMonth() + "', ";
                    update = true;
                }

                if (update) {
                    sQuery = sQuery.substring(0, sQuery.length() - 2);
                    sQuery += " WHERE codpublication = " + codPublication + ";";
                    stm.execute(sQuery);
                }

                sQuery = "UPDATE integrado.article SET ";
                update = false;

                if (!article.getCdrom().equals(articleAnt.getCdrom())) {
                    sQuery += "cdrom = '" + article.getCdrom() + "', ";
                    update = true;
                }
                if (!article.getStartPage().equals(articleAnt.getStartPage())) {
                    sQuery += "startPage = '" + article.getStartPage() + "', ";
                    update = true;
                }
                if (!article.getEndPage().equals(articleAnt.getEndPage())) {
                    sQuery += "endPage = '" + article.getEndPage() + "', ";
                    update = true;
                }

                if (update) {
                    sQuery = sQuery.substring(0, sQuery.length() - 2);
                    sQuery += " WHERE codpublication = " + codPublication + ";";
                    stm.execute(sQuery);
                }
            }
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void deletePublication(Publication publication, String login) throws PublicationDAOException {
        String sQuery = "DELETE from integrado.publication WHERE title='" + publication.getTitle() + "' AND type='" + publication.getType() + "' ";
        System.out.println(sQuery);
        if (login != null) {
            sQuery += "AND loginUser='" + login + "' ";
        }

        System.out.println(sQuery);

        try {
            stm.execute(sQuery);
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public Vector searchPublication(String filtro, String param) throws PublicationDAOException {
        Vector<Publication> publications = new Vector();
        ResultSet rs = null;
        Publication publication;
        String sQuery = "";
        try {
            if (filtro.equals("isbn")) {
                sQuery = "select * from view_search_isbn where isbn like '" + param + "%' order by isbn;";
            } else if (filtro.equals("journal")) {
                sQuery = "select * from view_search_journal where journal = '" + param + "' order by journal;";
            }
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String title = rs.getString("title");
                String type = rs.getString("type");
                double cod = rs.getDouble("codPublication");
                String p = "";
                if (filtro.equals("isbn")) {
                    p = rs.getString("isbn");
                } else if (filtro.equals("journal")) {
                    p = rs.getString("journal");
                }
                publication = new Publication();
                publication.setTitle(title);
                publication.setType(type);
                publication.setCod(cod);
                if (filtro.equals("isbn")) {
                    publication.setIsbn(p);
                } else if (filtro.equals("journal")) {
                    publication.setJournal(p);
                }
                publications.addElement(publication);
            }
            Statement stm2 = con.createStatement();
            for (int i = 0; i < publications.size(); i++) {
                double cod = publications.get(i).getCod();
                String table = "";
                if (filtro.equals("isbn")) {
                    table = "view_isbn_author";
                } else if (filtro.equals("journal")) {
                    table = "view_journal_author";
                }
                sQuery = "select nameAuthor from " + table + " where codPublication = " + cod + " order by nameAuthor;";
                stm2.execute(sQuery);
                rs = stm2.getResultSet();

                while (rs.next()) {
                    Author a = new Author();
                    a.setName(rs.getString("nameAuthor"));
                    publications.get(i).addAuthor(a);
                }
            }
            for (int i = 0; i < publications.size(); i++) {
                String p = "";
                if (filtro.equals("isbn")) {
                    p = publications.get(i).getIsbn();
                    sQuery = "select journal from view_search_journal_isbn where isbn = '" + p + "' order by journal;";
                } else if (filtro.equals("journal")) {
                    p = publications.get(i).getJournal();
                    sQuery = "select isbn from view_search_journal_isbn where journal = '" + p + "' order by isbn;";
                }
                stm2.execute(sQuery);
                rs = stm2.getResultSet();

                while (rs.next()) {
                    if (filtro.equals("isbn")) {
                        publications.get(i).setJournal(rs.getString("journal"));
                    } else if (filtro.equals("journal")) {
                        publications.get(i).setIsbn(rs.getString("isbn"));
                    }
                }
            }
            System.out.println("Size: " + publications.size());
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
        return publications;
    }

    public Vector getEvents(String sql) throws PublicationDAOException {
        ResultSet rs = null;
        Vector events = new Vector();
        Booktitle b;

        try {
            stm.execute(sql);
            rs = stm.getResultSet();

            while (rs.next()) {
                b = new Booktitle();
                b.setCod(rs.getInt("cod"));
                b.setName(rs.getString("name"));

                if (rs.getString("startDate") != null) {
                    b.setStartDate(rs.getString("startDate"));
                } else {
                    b.setStartDate("");
                }

                if (rs.getString("endDate") != null) {
                    b.setEndDate(rs.getString("endDate"));
                } else {
                    b.setEndDate("");
                }

                if (rs.getString("local") != null) {
                    b.setLocal(rs.getString("local"));
                } else {
                    b.setLocal("");
                }

                events.addElement(b);
            }

            return events;

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveEvent(Booktitle b) throws PublicationDAOException {
        String codigo = "SELECT max(cod) FROM integrado.bookTitle";
        ResultSet rs = null;

        try {
            stm.execute(codigo);
            rs = stm.getResultSet();
            double cod = 1;

            if (rs.next()) {
                cod = rs.getDouble(1);
                cod = cod + 1;

                String sql = "INSERT INTO integrado.bookTitle VALUES ( " + cod
                        + ", '" + b.getName() + "', '" + b.getStartDate() + "', '"
                        + b.getEndDate() + "', '" + b.getLocal() + "');";

                stmTeste.execute(sql);
                System.out.println("EXECUTOU");
            }

        } catch (Exception e) {
            System.out.println("PEPRINOOO");
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public Vector getNews() throws PublicationDAOException {
        Vector news = new Vector();
        ResultSet rs = null;
        ResultSet rsPub = null;
        ResultSet rsEv = null;
        double id_pub;
        int id_ev, i = 0;
        int qtde = 50;
        String data;
        News n;

        String sql = "SELECT TOP 30 ID_PUB, ID_EV, DATA FROM integrado.news ORDER BY DATA DESC";

        try {
            stm.execute(sql);
            rs = stm.getResultSet();

            while (i < qtde && rs.next()) {
                id_pub = rs.getDouble("ID_PUB");
                id_ev = rs.getInt("ID_EV");
                data = rs.getString("DATA");

                if (id_pub == 0) {
                    //booktitle
                    String sqlEv = "SELECT name FROM integrado.bookTitle WHERE cod =" + id_ev;
                    stmTeste.execute(sqlEv);
                    rsEv = stmTeste.getResultSet();

                    while (rsEv.next()) {
                        n = new News();
                        n.setName(rsEv.getString("name"));
                        n.setType(1);
                        n.setDate(data);
                        news.addElement(n);
                        i++;
                    }

                } else {
                    //publications
                    String sqlPub = "SELECT title FROM integrado.publication WHERE cod =" + id_pub;
                    stmTeste.execute(sqlPub);
                    rsPub = stmTeste.getResultSet();

                    while (rsPub.next()) {
                        n = new News();
                        n.setName(rsPub.getString("title"));
                        n.setType(0);
                        n.setDate(data);
                        news.addElement(n);
                        i++;
                    }
                }
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }

        return news;
    }

    public void updateUpgrade(String login, boolean upgrade) throws PublicationDAOException {
        String statement = "UPDATE integrado.userData SET upgrade = 0 ";
        try {
            if (upgrade) {
                statement += ", profile = 1 ";
            }

            statement += "WHERE login = '" + login + "';";
            System.out.println("Sss: " + statement);
            stm.execute(statement);
            //Enviar email para o usuÃ¡rio
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void insertPost(Double codPublication, String userLogin, String text) throws PublicationDAOException {
        String statement = "INSERT INTO integrado.post (codPublication, userLogin, text) VALUES ("
                + codPublication + ", '" + userLogin + "', '" + text + "');";

        try {
            System.out.println("Sss: " + statement);
            stm.execute(statement);

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public ArrayList<Post> getPosts(double codPublication) throws PublicationDAOException {
        ArrayList<Post> posts = new ArrayList<Post>();

        try {
            String sQuery = "SELECT userLogin, insertion, text FROM integrado.post WHERE codPublication = " + codPublication + " ORDER BY insertion DESC;";
            ResultSet result = this.executeQuery(sQuery);

            while (result.next()) {
                Post post = new Post();
                post.setUser(result.getString(1));
                post.setDate(result.getTimestamp(2));
                post.setText(result.getString(3));
                posts.add(post);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }

        return posts;
    }

    public ArrayList<User> getUpdateRequests() throws PublicationDAOException {
        ArrayList<User> users = new ArrayList<User>();

        try {
            String sQuery = "SELECT login, name, page FROM integrado.userData WHERE upgrade = 1;";
            ResultSet result = this.executeQuery(sQuery);

            while (result.next()) {
                User user = new User();
                user.setLogin(result.getString(1));
                user.setName(result.getString(2));
                user.setPage(result.getString(3));
                users.add(user);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }

        return users;
    }

    public boolean inserirNovoTema(String newTheme) throws PublicationDAOException {
        String query = "SELECT * FROM integrado.subject WHERE subject = '" + newTheme + "';";
        try {
            ResultSet rs = stm.executeQuery(query);
            if (rs.next()) {
                return false;
            }

            query = "Select max(cod) as cod from integrado.subject;";
            Statement stm3 = con.createStatement();
            ResultSet rs2 = stm3.executeQuery(query);
            int cod = 0;
            while (rs2.next()) {
                cod = rs2.getInt("cod");
            }
            cod++;

            query = "INSERT INTO integrado.subject VALUES(" + cod + ",'" + newTheme + "');";
            Statement stm2 = con.createStatement();
            stm2.execute(query);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            //throw new PublicationDAOException();
            return false;
        }
    }
}
