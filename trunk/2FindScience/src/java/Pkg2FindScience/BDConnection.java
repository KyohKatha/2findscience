package Pkg2FindScience;

import java.sql.*;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
            ds.setServerName("192.168.12.4");
            con = ds.getConnection();
            stm = con.createStatement();
            stmTeste = con.createStatement();
        } catch (Exception e) {
            try {
                SQLServerDataSource ds = new SQLServerDataSource();
                ds.setUser("317624");
                ds.setPassword("#gustavo123");
                ds.setDatabaseName("317624");
                ds.setServerName("189.109.33.220");
                con = ds.getConnection();
                stm = con.createStatement();
                stmTeste = con.createStatement();
            } catch (Exception j) {
                throw new PublicationDAOException();
            }
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

                CallableStatement st = con.prepareCall("{call sp_check_subjects (?,?)}");
                st.setString("login", login);
                st.registerOutParameter(2, Types.BOOLEAN);
                st.execute();
                boolean status = st.getBoolean(2);
                st.close();
                user.setHaveSubjects(status);
            } else {
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

        try {
            String sQuery = "SELECT Top 100 subject FROM integrado.subject ORDER BY(subject);";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String name = rs.getString("subject");
                subjects.addElement(name);
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

            if (subjects != null && !subjects.equals("")) {
                String[] vectorSubjects = subjects.split(";");

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

    public Vector getAuthors() throws PublicationDAOException {
        Vector authors = new Vector();
        ResultSet rs = null;

        try {
            String sQuery = "SELECT TOP 500 name FROM integrado.author ORDER BY name;";
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
            String sQuery = "SELECT name FROM integrado.bookTitle ORDER BY name;";
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

    public void deletePublication(Publication publication, String login) throws PublicationDAOException {
        String sQuery = "DELETE from integrado.publication WHERE title='" + publication.getTitle() + "' AND type='" + publication.getType() + "' ";

        if (login != null) {
            sQuery += "AND loginUser='" + login + "' ";
        }

        try {
            stm.execute(sQuery);
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public Vector searchPublication(String filtro, String param) throws PublicationDAOException {
        Vector<Publication> publications = new Vector();
        Publication publication;

        try {
            String sQuery = "";
            CallableStatement st = null;
            Statement stm3 = null;
            ResultSet rs = null;

            if (filtro.equals("isbn")) {
                st = con.prepareCall("{call sp_search_isbn (?)}");
                st.setString(1, param);
                rs = st.executeQuery();
            } else if (filtro.equals("journal")) {
                st = con.prepareCall("{call sp_search_journal (?)}");
                st.setString(1, param);
                rs = st.executeQuery();
            } else if (filtro.equals("both")) {
                stm3 = con.createStatement();
                rs = stm3.executeQuery("select * from fc_search_isbn_journal('" + param + "') ORDER BY numPubs DESC;");
            }

            while (rs.next()) {
                String title = rs.getString("title");
                double cod = rs.getDouble("codPublication");
                String p = "";
                if (filtro.equals("isbn")) {
                    p = rs.getString("isbn");
                } else if (filtro.equals("journal")) {
                    p = rs.getString("journal");
                } else if (filtro.equals("both")) {
                    p = rs.getString("param");
                }
                publication = new Publication();
                publication.setTitle(title);
                //publication.setType(type);
                publication.setCod(cod);
                if (filtro.equals("isbn")) {
                    publication.setIsbn(p);
                } else if (filtro.equals("journal")) {
                    publication.setJournal(p);
                } else if (filtro.equals("both")) {
                    boolean t = rs.getBoolean("type");
                    if (t) {
                        publication.setIsbn(p);
                    } else {
                        publication.setJournal(p);
                    }
                }
                publications.addElement(publication);
            }

            if (st != null) {
                st.close();
            }

            if (stm3 != null) {
                stm3.close();
            }

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

    public void saveEvent(Booktitle b, String subjects) throws PublicationDAOException {

        try {
            CallableStatement st = con.prepareCall("{call sp_insert_event(?, ?, ?, ?)}");

            st.setString(1, b.getName());

            if (!b.getStartDate().equals("")) {
                DateFormat fmt = new SimpleDateFormat("yyyy/MM/dd");
                java.sql.Date startDate = new java.sql.Date(fmt.parse(b.getStartDate()).getTime());
                st.setDate(2, startDate);
            } else {
                st.setDate(2, null);
            }
            if (!b.getEndDate().equals("")) {
                DateFormat fmt = new SimpleDateFormat("yyyy/MM/dd");
                java.sql.Date endDate = new java.sql.Date(fmt.parse(b.getEndDate()).getTime());
                st.setDate(3, endDate);
            } else {
                st.setString(3, null);
            }
            if (!b.getEndDate().equals("")) {
                st.setString(4, b.getLocal());
            } else {
                st.setString(4, null);
            }
            st.execute();
            st.close();

            if (subjects != null && !subjects.equals("")) {
                String sQuery = "SELECT cod FROM integrado.booktitle WHERE name='" + b.getName() + "';";
                ResultSet resultCod = stm.executeQuery(sQuery);

                if (resultCod.next()) {
                    int codEvent = resultCod.getInt("cod");
           
                    String[] vectorSubjects = subjects.split(";");
                    ResultSet result = null;

                    for (int i = 0; i < vectorSubjects.length; i++) {
                        sQuery = "SELECT cod FROM integrado.subject WHERE subject= '" + vectorSubjects[i] + "';";
                        stm.execute(sQuery);
                        result = stm.getResultSet();

                        if (result.next()) {
                            int cod = result.getInt("cod");
                            sQuery = "INSERT INTO integrado.booktitleSubject VALUES(" + codEvent + "," + cod + ");";
                            stm.execute(sQuery);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public Vector getNews() throws PublicationDAOException {
        Vector news = new Vector();
        ResultSet result = null;

        try {
             result = stm.executeQuery("SELECT * FROM fc_getnews() ORDER BY insertion DESC;");

             while(result.next()){
                 double cod = result.getDouble("cod");
                 String name = result.getString("name");
                 int type = result.getInt("type");
                 String date = result.getString("insertion");

                 News n = new News(cod, type, date, name);
                 news.add(n);
             }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return news;
    }

    public Vector getNewsUser(String login) throws PublicationDAOException{
        Vector news = new Vector();
        ResultSet result = null;

        try {
             result = stm.executeQuery("SELECT * from fc_getnewsUser('" + login + "') ORDER BY insertion DESC;");

             while(result.next()){
                 double cod = result.getDouble("cod");
                 String name = result.getString("name");
                 int type = result.getInt("type");
                 String date = result.getString("insertion");

                 News n = new News(cod, type, date, name);
                 news.add(n);
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
        String statement = "INSERT INTO integrado.post (codPublication, userLogin, text) VALUES (" + codPublication + ", '" + userLogin + "', '" + text + "');";

        try {
            System.out.println("Sss: " + statement);
            stm.execute(statement);

        } catch (Exception e) {
            e.printStackTrace();
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

    public void updateEvent(Booktitle b) throws PublicationDAOException {

        try {
            CallableStatement st = con.prepareCall("{call sp_update_event(?, ?, ?, ?, ?)}");

            st.setString(1, b.getName());
            // inserir null em vez de string vazia
            if (!b.getStartDate().equals("")) {
                DateFormat fmt = new SimpleDateFormat("yyyy/MM/dd");
                java.sql.Date startDate = new java.sql.Date(fmt.parse(b.getStartDate()).getTime());
                st.setDate(2, startDate);
            } else {
                st.setDate(2, null);
            }
            if (!b.getEndDate().equals("")) {
                DateFormat fmt = new SimpleDateFormat("yyyy/MM/dd");
                java.sql.Date endDate = new java.sql.Date(fmt.parse(b.getEndDate()).getTime());
                st.setDate(3, endDate);
            } else {
                st.setString(3, null);
            }
            if (!b.getEndDate().equals("")) {
                st.setString(4, b.getLocal());
            } else {
                st.setString(4, null);
            }
            System.out.println(b.getCod());
            st.setInt(5, b.getCod());

            st.execute();

            st.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public Vector getUsers(String sql) throws PublicationDAOException {
        ResultSet rs = null;
        Vector users = new Vector();
        User s;

        try {
            Statement stm2 = con.createStatement();
            stm2.execute(sql);
            rs = stm2.getResultSet();

            while (rs.next()) {
                s = new User();
                s.setEmail(rs.getString("email"));
                s.setLogin(rs.getString("login"));
                s.setName(rs.getString("name"));
                s.setNumTrialUpgrade(rs.getInt("numTrialUpgrade"));
                s.setPage(rs.getString("page"));
                s.setPassword(rs.getString("password"));
                s.setProfile(rs.getInt("profile"));
                s.setUpgrade(rs.getInt("upgrade"));
                users.addElement(s);

            }

            return users;

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveUser(User u) throws PublicationDAOException {
        try {

            String sql = "UPDATE integrado.userData SET name = '" + u.getName() + "', email = '" + u.getEmail() + "', page = '" + u.getPage() + "', profile = " + u.getProfile() + " where login = '" + u.getLogin() + "';";

            stm.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    /***************GUSTAVO****************/
    public Vector getEditor() throws PublicationDAOException {
        Vector editor = new Vector();
        ResultSet rs = null;

        try {
            String sQuery = "SELECT name FROM integrado.editor ORDER BY name;";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String name = rs.getString("name");
                editor.addElement(name);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return editor;
    }

    public Vector getPublisher() throws PublicationDAOException {
        Vector publisher = new Vector();
        ResultSet rs = null;

        try {
            String sQuery = "SELECT name FROM integrado.publisher ORDER BY name;";
            stm.execute(sQuery);
            rs = stm.getResultSet();

            while (rs.next()) {
                String name = rs.getString("name");
                publisher.addElement(name);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return publisher;
    }

    public void saveMasterThesis(MasterThesis masterThesis, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_masterThesis (?,?,?,?) }");

            st.setString("title", masterThesis.getTitle());

            if (masterThesis.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", masterThesis.getUrl());
            }

            if (masterThesis.getSchool().equals("")) {
                st.setString("school", null);
            } else {
                st.setString("school", masterThesis.getSchool());
            }
            st.setString("loginUser", login);
            st.execute();
            st.close();

            if (!masterThesis.getStrAuthors().equals("") || !subjects.equals("")) {
                String sQuery = "SELECT cod FROM integrado.publication WHERE title='" + masterThesis.getTitle() + "' AND loginUser='" + login + "';";
                stm.execute(sQuery);
                ResultSet result = stm.getResultSet();
                double codPublication = -1;

                if (result.next()) {
                    codPublication = result.getDouble("cod");
                    this.saveAuthorPublication(masterThesis.getStrAuthors(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void savePhdThesis(PhdThesis phdThesis, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_phdthesis (?,?,?,?,?,?,?,?,?) }");

            st.setString("title", phdThesis.getTitle());

            if (phdThesis.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", phdThesis.getUrl());
            }

            if (phdThesis.getSchool().equals("")) {
                st.setString("school", null);
            } else {
                st.setString("school", phdThesis.getSchool());
            }

            if (phdThesis.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setString("number", phdThesis.getNumber());
            }

            if (phdThesis.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setString("volume", phdThesis.getVolume());
            }

            if (phdThesis.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", phdThesis.getMonth());
            }

            if (phdThesis.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", phdThesis.getEe());
            }

            if (phdThesis.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", phdThesis.getIsbn());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            sQuery = "SELECT cod FROM integrado.publication WHERE title='" + phdThesis.getTitle() + "' AND loginUser='" + login + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();
            double codPublication = -1;

            if (result.next()) {
                codPublication = result.getDouble("cod");
                if (!phdThesis.getStrAuthors().equals("") || !subjects.equals("")) {
                    this.saveAuthorPublication(phdThesis.getStrAuthors(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }

            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveArticle(Article article, String login, String subjects) throws PublicationDAOException {
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

            if (!article.getBookTitle().equals("") || !article.getStrAuthors().equals("") || !article.getEditor().equals("") || !article.getPublisher().equals("") || !subjects.equals("")) {
                sQuery = "SELECT cod FROM integrado.publication WHERE title='" + article.getTitle() + "' AND loginUser='" + login + "';";
                stm.execute(sQuery);
                result = stm.getResultSet();
                double codPublication = -1;

                if (result.next()) {
                    codPublication = result.getDouble("cod");
                    this.saveAuthorPublication(article.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(article.getBookTitle(), codPublication);
                    this.saveEditorDocument(article.getEditor(), codPublication);
                    this.savePublisherDocument(article.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public void saveInproceedings(Inproceedings inproceedings, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_inproceedings (?,?,?,?,?,?,?,?,?,?) }");
            st.setString("title", inproceedings.getTitle());

            if (inproceedings.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", inproceedings.getUrl());
            }

            if (inproceedings.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", inproceedings.getEe());
            }

            if (inproceedings.getStartPage().equals("")) {
                st.setString("startPage", null);
            } else {
                st.setInt("startPage", Integer.parseInt(inproceedings.getStartPage()));
            }

            if (inproceedings.getEndPage().equals("")) {
                st.setString("endPage", null);
            } else {
                st.setInt("endPage", Integer.parseInt(inproceedings.getEndPage()));
            }

            if (inproceedings.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", inproceedings.getCdrom());
            }

            if (inproceedings.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", inproceedings.getNote());
            }

            if (inproceedings.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setInt("number", Integer.parseInt(inproceedings.getNumber()));
            }

            if (inproceedings.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", inproceedings.getMonth());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            if (!inproceedings.getBookTitle().equals("") || !inproceedings.getStrAuthors().equals("") || !inproceedings.getEditor().equals("") || !inproceedings.getPublisher().equals("") || !subjects.equals("")) {
                sQuery = "SELECT cod FROM integrado.publication WHERE title='" + inproceedings.getTitle() + "' AND loginUser='" + login + "';";
                stm.execute(sQuery);
                result = stm.getResultSet();
                double codPublication = -1;

                if (result.next()) {
                    codPublication = result.getDouble("cod");
                    this.saveAuthorPublication(inproceedings.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(inproceedings.getBookTitle(), codPublication);
                    this.saveEditorDocument(inproceedings.getEditor(), codPublication);
                    this.savePublisherDocument(inproceedings.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveBook(Book book, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_book (?,?,?,?,?,?,?,?) }");
            st.setString("title", book.getTitle());

            if (book.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", book.getUrl());
            }

            if (book.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", book.getEe());
            }

            if (book.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", book.getCdrom());
            }

            if (book.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setInt("volume", Integer.parseInt(book.getVolume()));
            }

            if (book.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", book.getMonth());
            }

            if (book.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", book.getIsbn());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            sQuery = "SELECT cod FROM integrado.publication WHERE title='" + book.getTitle() + "' AND loginUser='" + login + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();
            double codPublication = -1;

            if (result.next()) {
                codPublication = result.getDouble("cod");
                if (!book.getBookTitle().equals("") || !book.getStrAuthors().equals("") || !book.getEditor().equals("") || !book.getPublisher().equals("") || !subjects.equals("")) {
                    this.saveAuthorPublication(book.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(book.getBookTitle(), codPublication);
                    this.saveEditorDocument(book.getEditor(), codPublication);
                    this.savePublisherDocument(book.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public void saveIncollection(Incollection incollection, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_incollection (?,?,?,?,?,?,?,?,?) }");
            st.setString("title", incollection.getTitle());

            if (incollection.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", incollection.getUrl());
            }

            if (incollection.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", incollection.getEe());
            }

            if (incollection.getChapter().equals("")) {
                st.setString("chapter", null);
            } else {
                st.setInt("chapter", Integer.parseInt(incollection.getChapter()));
            }

            if (incollection.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", incollection.getCdrom());
            }

            if (incollection.getStartPage().equals("")) {
                st.setString("startPage", null);
            } else {
                st.setInt("startPage", Integer.parseInt(incollection.getStartPage()));
            }
            if (incollection.getEndPage().equals("")) {
                st.setString("endPage", null);
            } else {
                st.setInt("endPage", Integer.parseInt(incollection.getEndPage()));
            }

            if (incollection.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", incollection.getIsbn());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            sQuery = "SELECT cod FROM integrado.publication WHERE title='" + incollection.getTitle() + "' AND loginUser='" + login + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();
            double codPublication = -1;

            if (result.next()) {
                codPublication = result.getDouble("cod");
                if (!incollection.getBookTitle().equals("") || !incollection.getStrAuthors().equals("") || !incollection.getEditor().equals("") || !incollection.getPublisher().equals("") || !subjects.equals("")) {
                    this.saveAuthorPublication(incollection.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(incollection.getBookTitle(), codPublication);
                    this.saveEditorDocument(incollection.getEditor(), codPublication);
                    this.savePublisherDocument(incollection.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }

            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveWww(Www www, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_www (?,?,?,?,?) }");
            st.setString("title", www.getTitle());

            if (www.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", www.getUrl());
            }

            if (www.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", www.getEe());
            }

            if (www.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", www.getNote());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            if (!www.getBookTitle().equals("") || !www.getStrAuthors().equals("") || !www.getEditor().equals("") || !www.getPublisher().equals("") || !subjects.equals("")) {
                sQuery = "SELECT cod FROM integrado.publication WHERE title='" + www.getTitle() + "' AND loginUser='" + login + "';";
                stm.execute(sQuery);
                result = stm.getResultSet();
                double codPublication = -1;

                if (result.next()) {
                    codPublication = result.getDouble("cod");
                    this.saveAuthorPublication(www.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(www.getBookTitle(), codPublication);
                    this.saveEditorDocument(www.getEditor(), codPublication);
                    this.savePublisherDocument(www.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void saveProceedings(Proceedings proceedings, String login, String subjects) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_insert_proceedings (?,?,?,?,?,?,?,?,?,?,?) }");
            st.setString("title", proceedings.getTitle());

            if (proceedings.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", proceedings.getUrl());
            }

            if (proceedings.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", proceedings.getEe());
            }

            if (proceedings.getJournal().equals("")) {
                st.setString("journal", null);
            } else {
                st.setString("journal", proceedings.getJournal());
            }

            if (proceedings.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setInt("volume", Integer.parseInt(proceedings.getVolume()));
            }

            if (proceedings.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setInt("number", Integer.parseInt(proceedings.getNumber()));
            }

            if (proceedings.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", proceedings.getNote());
            }

            if (proceedings.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", proceedings.getMonth());
            }

            if (proceedings.getAddress().equals("")) {
                st.setString("address", null);
            } else {
                st.setString("address", proceedings.getAddress());
            }

            if (proceedings.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", proceedings.getIsbn());
            }

            st.setString("loginUser", login);
            st.execute();
            st.close();

            ResultSet result = null;
            String sQuery = null;

            sQuery = "SELECT cod FROM integrado.publication WHERE title='" + proceedings.getTitle() + "' AND loginUser='" + login + "';";
            stm.execute(sQuery);
            result = stm.getResultSet();
            double codPublication = -1;

            if (result.next()) {
                codPublication = result.getDouble("cod");
                if (!proceedings.getBookTitle().equals("") || !proceedings.getStrAuthors().equals("") || !proceedings.getEditor().equals("") || !proceedings.getPublisher().equals("") || !subjects.equals("")) {
                    codPublication = result.getDouble("cod");
                    this.saveAuthorPublication(proceedings.getStrAuthors(), codPublication);
                    this.saveBookTitleDocument(proceedings.getBookTitle(), codPublication);
                    this.saveEditorDocument(proceedings.getEditor(), codPublication);
                    this.savePublisherDocument(proceedings.getPublisher(), codPublication);
                    this.saveSubjectPublication(codPublication, subjects);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public Article setArticle(double codPublication) throws PublicationDAOException {
        Article article = null;
        ResultSet result = null;
        String sQuery = "SELECT * FROM view_article WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
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

                article = new Article(title, url, ee, journal,
                        volume, note, number, month, cdrom, startPage, endPage, null, null, null, null, codPublication);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return article;
    }

    public Incollection setIncollection(double codPublication) throws PublicationDAOException {
        Incollection incollection = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, chapter, startPage, endPage, cdrom FROM view_incollection WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String chapter = result.getString("chapter");
                String startPage = result.getString("startPage");
                String endPage = result.getString("endPage");
                String cdrom = result.getString("cdrom");

                incollection = new Incollection(title, url, ee, startPage, endPage, cdrom, chapter, null, null, null, null, null, codPublication);
            }

            sQuery = "SELECT isbn FROM integrado.isbn WHERE codPublication = " + codPublication + ";";
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String isbn = result.getString("isbn");
                incollection.setIsbn(isbn);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return incollection;
    }

    public Book setBook(double codPublication) throws PublicationDAOException {
        Book book = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, volume, cdrom, month FROM view_book WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String volume = result.getString("volume");
                String cdrom = result.getString("cdrom");
                String month = result.getString("month");

                book = new Book(title, url, ee, volume, cdrom, month, null, null, null, null, null, codPublication);
            }

            sQuery = "SELECT isbn FROM integrado.isbn WHERE codPublication = " + codPublication + ";";
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String isbn = result.getString("isbn");
                book.setIsbn(isbn);
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return book;
    }

    public Inproceedings setInproceedings(double codPublication) throws PublicationDAOException {
        Inproceedings inproceedings = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, startPage, endPage, cdrom, note, number, month FROM view_inproceedings WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String startPage = result.getString("startPage");
                String endPage = result.getString("endPage");
                String cdrom = result.getString("cdrom");
                String note = result.getString("note");
                String number = result.getString("number");
                String month = result.getString("month");

                inproceedings = new Inproceedings(title, url, ee, startPage, endPage, cdrom, note, number, month, null, null, null, null, codPublication);
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return inproceedings;
    }

    public Proceedings setProceedings(double codPublication) throws PublicationDAOException {
        Proceedings proceedings = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, journal, volume, number, note, month, address  FROM view_proceedings WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String journal = result.getString("journal");
                String volume = result.getString("volume");
                String number = result.getString("number");
                String note = result.getString("note");
                String month = result.getString("month");
                String address = result.getString("address");

                proceedings = new Proceedings(title, url, ee, journal, volume, number, note, month, address, null, null, null, null, null, codPublication);
            }

            sQuery = "SELECT isbn FROM integrado.isbn WHERE codPublication = " + codPublication + ";";
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String isbn = result.getString("isbn");
                proceedings.setIsbn(isbn);
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return proceedings;
    }

    public PhdThesis setPhdThesis(double codPublication) throws PublicationDAOException {
        PhdThesis phdThesis = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, volume, school, number, month  FROM view_phdThesis WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String volume = result.getString("volume");
                String school = result.getString("school");
                String number = result.getString("number");
                String month = result.getString("month");

                phdThesis = new PhdThesis(title, url, school, number, volume, month, ee, null, null, codPublication);
            }

            sQuery = "SELECT isbn FROM integrado.isbn WHERE codPublication = " + codPublication + ";";
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String isbn = result.getString("isbn");
                phdThesis.setIsbn(isbn);
            }

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return phdThesis;
    }

    public Www setWww(double codPublication) throws PublicationDAOException {
        Www www = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, ee, note  FROM view_www WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String ee = result.getString("ee");
                String note = result.getString("note");

                www = new Www(title, url, ee, note, null, null, null, null, codPublication);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return www;
    }

    public MasterThesis setMastersThesis(double codPublication) throws PublicationDAOException {
        MasterThesis masterThesis = null;
        ResultSet result = null;
        String sQuery = "SELECT title, url, school  FROM view_masterThesis WHERE cod =" + codPublication + ";";

        try {
            stm.execute(sQuery);
            result = stm.getResultSet();

            if (result.next()) {
                String title = result.getString("title");
                String url = result.getString("url");
                String school = result.getString("school");

                masterThesis = new MasterThesis(title, url, school, null, codPublication);
            }
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
        return masterThesis;
    }

    public void updateArticle(Article article, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_article (?,?,?,?,?,?,?,?,?,?,?,?) }");
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

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void updatePhdThesis(PhdThesis phdThesis, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_phdthesis (?,?,?,?,?,?,?,?,?) }");

            st.setString("title", phdThesis.getTitle());

            if (phdThesis.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", phdThesis.getUrl());
            }

            if (phdThesis.getSchool().equals("")) {
                st.setString("school", null);
            } else {
                st.setString("school", phdThesis.getSchool());
            }

            if (phdThesis.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setString("number", phdThesis.getNumber());
            }

            if (phdThesis.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setString("volume", phdThesis.getVolume());
            }

            if (phdThesis.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", phdThesis.getMonth());
            }

            if (phdThesis.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", phdThesis.getEe());
            }

            if (phdThesis.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", phdThesis.getIsbn());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();

        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void updateMasterThesis(MasterThesis masterThesis, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_masterThesis (?,?,?,?) }");

            st.setString("title", masterThesis.getTitle());

            if (masterThesis.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", masterThesis.getUrl());
            }

            if (masterThesis.getSchool().equals("")) {
                st.setString("school", null);
            } else {
                st.setString("school", masterThesis.getSchool());
            }
            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public void updateInproceedings(Inproceedings inproceedings, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_inproceedings (?,?,?,?,?,?,?,?,?,?) }");
            st.setString("title", inproceedings.getTitle());

            if (inproceedings.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", inproceedings.getUrl());
            }

            if (inproceedings.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", inproceedings.getEe());
            }

            if (inproceedings.getStartPage().equals("")) {
                st.setString("startPage", null);
            } else {
                st.setInt("startPage", Integer.parseInt(inproceedings.getStartPage()));
            }

            if (inproceedings.getEndPage().equals("")) {
                st.setString("endPage", null);
            } else {
                st.setInt("endPage", Integer.parseInt(inproceedings.getEndPage()));
            }

            if (inproceedings.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", inproceedings.getCdrom());
            }

            if (inproceedings.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", inproceedings.getNote());
            }

            if (inproceedings.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setInt("number", Integer.parseInt(inproceedings.getNumber()));
            }

            if (inproceedings.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", inproceedings.getMonth());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void updateBook(Book book, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_book (?,?,?,?,?,?,?,?) }");
            st.setString("title", book.getTitle());

            if (book.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", book.getUrl());
            }

            if (book.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", book.getEe());
            }

            if (book.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", book.getCdrom());
            }

            if (book.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setInt("volume", Integer.parseInt(book.getVolume()));
            }

            if (book.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", book.getMonth());
            }

            if (book.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", book.getIsbn());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public void updateIncollection(Incollection incollection, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_incollection (?,?,?,?,?,?,?,?,?) }");
            st.setString("title", incollection.getTitle());

            if (incollection.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", incollection.getUrl());
            }

            if (incollection.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", incollection.getEe());
            }

            if (incollection.getChapter().equals("")) {
                st.setString("chapter", null);
            } else {
                st.setInt("chapter", Integer.parseInt(incollection.getChapter()));
            }

            if (incollection.getCdrom().equals("")) {
                st.setString("cdrom", null);
            } else {
                st.setString("cdrom", incollection.getCdrom());
            }

            if (incollection.getStartPage().equals("")) {
                st.setString("startPage", null);
            } else {
                st.setInt("startPage", Integer.parseInt(incollection.getStartPage()));
            }
            if (incollection.getEndPage().equals("")) {
                st.setString("endPage", null);
            } else {
                st.setInt("endPage", Integer.parseInt(incollection.getEndPage()));
            }

            if (incollection.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", incollection.getIsbn());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();


        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void updateWww(Www www, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_www (?,?,?,?,?) }");
            st.setString("title", www.getTitle());

            if (www.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", www.getUrl());
            }

            if (www.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", www.getEe());
            }

            if (www.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", www.getNote());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();

        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    public void updateProceedings(Proceedings proceedings, double codPublication) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{ call sp_update_proceedings (?,?,?,?,?,?,?,?,?,?,?) }");
            st.setString("title", proceedings.getTitle());

            if (proceedings.getUrl().equals("")) {
                st.setString("url", null);
            } else {
                st.setString("url", proceedings.getUrl());
            }

            if (proceedings.getEe().equals("")) {
                st.setString("ee", null);
            } else {
                st.setString("ee", proceedings.getEe());
            }

            if (proceedings.getJournal().equals("")) {
                st.setString("journal", null);
            } else {
                st.setString("journal", proceedings.getJournal());
            }

            if (proceedings.getVolume().equals("")) {
                st.setString("volume", null);
            } else {
                st.setInt("volume", Integer.parseInt(proceedings.getVolume()));
            }

            if (proceedings.getNumber().equals("")) {
                st.setString("number", null);
            } else {
                st.setInt("number", Integer.parseInt(proceedings.getNumber()));
            }

            if (proceedings.getNote().equals("")) {
                st.setString("note", null);
            } else {
                st.setString("note", proceedings.getNote());
            }

            if (proceedings.getMonth().equals("")) {
                st.setString("month", null);
            } else {
                st.setString("month", proceedings.getMonth());
            }

            if (proceedings.getAddress().equals("")) {
                st.setString("address", null);
            } else {
                st.setString("address", proceedings.getAddress());
            }

            if (proceedings.getIsbn().equals("")) {
                st.setString("isbn", null);
            } else {
                st.setString("isbn", proceedings.getIsbn());
            }

            st.setDouble("idPub", codPublication);
            st.execute();
            st.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
    }

    public void saveEditorDocument(String editor, double codPublication) throws PublicationDAOException {
        if (editor != null && !editor.equals("")) {
            String sQuery = null;
            ResultSet result = null;

            try {
                String[] vectorEditor = editor.split(";");

                for (int i = 0; i < vectorEditor.length; i++) {
                    sQuery = "SELECT cod FROM integrado.editor WHERE name like '" + this.formatField(vectorEditor[i]) + "';";
                    stm.execute(sQuery);

                    result = stm.getResultSet();

                    if (result.next()) {
                        int cod = result.getInt("cod");
                        sQuery = "INSERT INTO integrado.editorDocument VALUES (" + cod + "," + codPublication + ");";
                        stm.execute(sQuery);
                    }
                }
            } catch (Exception e) {
                throw new PublicationDAOException();
            }
        }
    }

    public void savePublisherDocument(String publisher, double codPublication) throws PublicationDAOException {
        if (publisher != null && !publisher.equals("")) {
            String sQuery = null;
            ResultSet result = null;

            try {
                String[] vectorPublisher = publisher.split(";");

                for (int i = 0; i < vectorPublisher.length; i++) {
                    sQuery = "SELECT cod FROM integrado.publisher WHERE name like '" + this.formatField(vectorPublisher[i]) + "';";
                    stm.execute(sQuery);

                    result = stm.getResultSet();

                    if (result.next()) {
                        int cod = result.getInt("cod");
                        sQuery = "INSERT INTO integrado.publisherDocument VALUES (" + codPublication + "," + cod + ");";
                        stm.execute(sQuery);
                    }
                }
            } catch (Exception e) {
                throw new PublicationDAOException();
            }
        }
    }

    public void saveBookTitleDocument(String bookTitle, double codPublication) throws PublicationDAOException {
        if (bookTitle != null && !bookTitle.equals("")) {
            ResultSet resultBook = null;
            bookTitle = bookTitle.substring(0, bookTitle.length() - 1);
            String sQuery = "SELECT cod FROM integrado.bookTitle WHERE name like '" + this.formatField(bookTitle) + "';";

            try {
                stm.execute(sQuery);
                resultBook = stm.getResultSet();

                if (resultBook.next()) {
                    int cod = resultBook.getInt("cod");
                    sQuery = "UPDATE integrado.document SET codBookTitle = " + cod + " WHERE codPublication=" + codPublication + ";";
                    stm.execute(sQuery);
                }
            } catch (Exception e) {
                throw new PublicationDAOException();
            }
        }
    }

    public void saveAuthorPublication(String authors, double codPublication) throws PublicationDAOException {
        if (authors != null && !authors.equals("")) {
            String sQuery = null;
            ResultSet result = null;

            try {
                String[] vectorAuthors = authors.split(";");

                for (int i = 0; i < vectorAuthors.length; i++) {
                    sQuery = "SELECT cod FROM integrado.author WHERE name like '" + this.formatField(vectorAuthors[i]) + "';";
                    stm.execute(sQuery);

                    result = stm.getResultSet();

                    if (result.next()) {
                        int cod = result.getInt("cod");
                        sQuery = "INSERT INTO integrado.authorPublication VALUES (" + codPublication + "," + cod + ");";
                        stm.execute(sQuery);
                    }
                }
            } catch (Exception e) {
                throw new PublicationDAOException();
            }
        }
    }

    public Publication getPublication(double cod) throws PublicationDAOException {
        Publication p = null;
        String sQuery = "";
        ResultSet rs;

        try {

            p = new Publication();
            p.setCod(cod);

            CallableStatement st2 = null;
            st2 = con.prepareCall("{call sp_get_publication_by_cod (?)}");
            st2.setDouble(1, cod);
            rs = st2.executeQuery();

            if (rs.next()) {
                p.setCod(cod);
                p.setTitle(rs.getString("title"));
                p.setUrl(rs.getString("url"));
                p.setloginUser(rs.getString("loginUser"));
                p.setType(rs.getString("type"));
            }

            CallableStatement st = null;
            st = con.prepareCall("{call sp_get_authors_by_pub (?)}");
            st.setDouble(1, cod);
            rs = st.executeQuery();

            while (rs.next()) {
                Author a = new Author();
                a.setName(rs.getString("name"));
                p.addAuthor(a);
            }

            sQuery = "select * from view_search_journal where codPublication = " + cod + ";";
            rs = stm.executeQuery(sQuery);

            if (rs.next()) {
                p.setJournal(rs.getString("journal"));
            }

            sQuery = "select * from view_search_isbn where codPublication = " + cod + ";";
            Statement stm2 = con.createStatement();
            rs = stm2.executeQuery(sQuery);
            if (rs.next()) {
                p.setIsbn(rs.getString("isbn"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }

        return p;
    }

    public boolean requestUpgrade(String login, String pwd) throws PublicationDAOException {
        boolean status = false;
        try {
            CallableStatement st = null;
            st = con.prepareCall("{call sp_request_upgrade (?,?,?)}");
            st.setString(1, login);
            st.setString(2, pwd);
            st.registerOutParameter(3, Types.BOOLEAN);
            st.execute();
            status = st.getBoolean(3);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }

        return status;
    }

    public void insertNewAuthor(String newAuthor) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{call sp_insert_new_author (?)}");
            st.setString(1, newAuthor);
            st.execute();
            st.close();
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void insertNewEditor(String newEditor) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{call sp_insert_new_editor (?)}");
            st.setString(1, newEditor);
            st.execute();
            st.close();
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void insertNewPublisher(String newPublisher) throws PublicationDAOException {
        try {
            CallableStatement st = con.prepareCall("{call sp_insert_new_publisher (?)}");
            st.setString(1, newPublisher);
            st.execute();
            st.close();
        } catch (SQLException e) {
            throw new PublicationDAOException();
        }
    }

    public void deleteSubject(String subject) throws PublicationDAOException {
        try {
            String sQuery = "DELETE FROM integrado.subject WHERE subject = '" + subject + "';";
            stm.execute(sQuery);
        } catch (Exception e) {
            throw new PublicationDAOException();
        }
    }

    private void saveSubjectPublication(double codPublication, String subjects) throws PublicationDAOException {
        String sQuery = null;
        ResultSet result = null;

        try {
            if (subjects != null && !subjects.equals("")) {
                String[] vectorSubjects = subjects.split(";");

                for (int i = 0; i < vectorSubjects.length; i++) {
                    sQuery = "SELECT cod FROM integrado.subject WHERE subject= '" + vectorSubjects[i] + "';";
                    stm.execute(sQuery);
                    result = stm.getResultSet();

                    if (result.next()) {
                        int cod = result.getInt("cod");
                        sQuery = "INSERT INTO integrado.publicationSubject VALUES(" + codPublication + "," + cod + ");";
                        stm.execute(sQuery);
                    }
                }
            }

        } catch (Exception e) {
            throw new PublicationDAOException("<p>- Error <strong>save</strong> data</p> <p>- Please try again</p>");
        }
    }

    public int getMaxUpgrade() throws PublicationDAOException {
        int max = 0;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM integrado.settings";
            rs = stm.executeQuery(sql);

            if (rs.next()) {
                max = rs.getInt("upgrade");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
        return max;
    }

    public String getEmail(String login) throws PublicationDAOException {
        String email = "";
        ResultSet rs = null;
        try {
            String sql = "SELECT email FROM integrado.userData where login = '" + login + "'";
            rs = stm.executeQuery(sql);

            if (rs.next()) {
                email = rs.getString("email");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new PublicationDAOException();
        }
        return email;
    }
}