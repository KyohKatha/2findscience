/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var xmlhttp

function loadContent(url, div)
{
    xmlhttp=GetXmlHttpObject();

    if (xmlhttp==null) {
        alert ("Your browser does not support Ajax HTTP");
        return;
    }

    url = "Ajax" + url;

    if (document.getElementById("loading") != null ){
        document.getElementById("loading").innerHTML="<p><img alt=\"Loading...\" src=\"http://img375.imageshack.us/img375/2134/ajaxloader.gif\"></p>";
    }
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState==4 && xmlhttp.status == 200) {
            document.getElementById(div).innerHTML=xmlhttp.responseText;
            if (document.getElementById("loading") != null )
                document.getElementById("loading").innerHTML="";
        }
    }
   
    xmlhttp.open("GET",url,true);
    
    xmlhttp.send(null);

}

function GetXmlHttpObject()
{
    try {
        // Firefox, Opera 8.0+, Safari
        return new XMLHttpRequest();
    } catch (e) {
        // Internet Explorer
        try {
            return new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e){
            try {
                return new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }
    return null;
}

function showMessage(type, message) {
    switch (type) {
        case 'information':
            document.getElementById("msg").innerHTML = "<fieldset class=\"information\" onclick=\"closeMessageBox()\"><legend>Information</legend>" + message + "</fieldset>";
            break;
        case 'critical':
            document.getElementById("msg").innerHTML = "<fieldset class=\"critical\" onclick=\"closeMessageBox()\"><legend>Error</legend>" + message + "</fieldset>";
            break;
        case 'success':
            document.getElementById("msg").innerHTML = "<fieldset class=\"success\" onclick=\"closeMessageBox()\"><legend>Success</legend>" + message + "</fieldset>";
            break;
        case 'warning':
            document.getElementById("msg").innerHTML = "<fieldset class=\"warning\" onclick=\"closeMessageBox()\"><legend>Warning</legend>" + message + "</fieldset>";
            break;
    }
}

function validateFormUser(acao){
    
    form = document.getElementById("formUser");
    var message = "";
    var login = trim(form.login.value);
    var name = trim(form.name.value);
    var email = trim(form.email.value);
    var page = trim(form.page.value);
    
    if(acao != "save"){
        var password = trim(form.password.value);
        var passwordConfirmation = trim(form.passwordConfirmation.value);
    }
    

    if (login == ""){
        message += ("<p>- <strong>Login</strong> is required!</p>");
        form.login.focus();
    }

    if (name == ""){
        message += ("<p>- <strong>Name</strong> is required!</p>");
        form.name.focus();
    }
    if(acao != "save"){
        if (password == ""){
            message += ("<p>- <strong>Password</strong> is required!</p>");
            form.password.focus();
        }

        if (passwordConfirmation == ""){
            message += ("<p>- <strong>Password Confirmation</strong> is required!</p>");
            form.passwordConfirmation.focus();
        }
        if(form.password.value != form.passwordConfirmation.value){
            message += ("<p>- <strong>Password</strong> and <strong>Confirmation</strong> don't match!</p>");
            form.password.focus();
        }
    }
    if (email != ""){
        if( email.match( /[a-z|A-Z|0-9]{2,8}@[a-z|A-Z|0-9]{2,20}\.[a-z]{3}([\.]{1}[a-z]{2})*/ ) == null ){
            message += ("<p>- <strong>Email</strong> is in incorrect format!</p>");
            form.email.focus();
        }
    }

    
    if(page != "http://" && page != ""){
        if(page.match( /http:\/\/[a-z|A-Z|0-9]{1,50}.[a-z]{3}/) == null ){
            message += ("<p>- <strong>Personal Page</strong> is incorrect format!</p>");
            form.page.focus();
        }
    }else{
        form.page.value="";
    }
    
    //message += "<p>- Click on the box to close it.</p>";

    if(message != ""){
        showMessage('critical', message);
        return false;
    }

    if(acao != "save")
        var subjectsParameter = document.getElementById("subjects").value;
    var url;

    if(acao == "Register"){
        url = "MaintenanceUserData?action=saveRegister&login=" + login + "&password=" + password +
        "&name=" + name + "&email=" + email + "&page=" + page + "&subjects=" +  subjectsParameter;
    }else if(acao == "save"){
        url = "MaintenanceUserData?action=save&login=" + form.login.value + "&name=" + form.name.value + "&email=" + form.email.value + "&page=" + form.page.value + "&profile=" + form.profile.value;
    }else{
        url = "MaintenanceUserData?action=updateProfile&profile=" + form.profile.value + "&login=" + login + "&password=" + password +
        "&name=" + name + "&email=" + email + "&page=" + page + "&subjects=" +  subjectsParameter;
    }
    
    callServlet(url, "AjaxContent");
    return true;
}

function getXMLHTTPRequest(){
    if (window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest();
    }
    else {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}

function callServlet(url,div){
    if (document.getElementById("loading") != null ){
        document.getElementById("loading").innerHTML="<p><img alt=\"Loading...\" src=\"http://img375.imageshack.us/img375/2134/ajaxloader.gif\"></p>";
    }

    HttpMethod = "POST";
    var req = null;
    req = getXMLHTTPRequest();
    if (req){
        req.open(HttpMethod,url,false);
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.setRequestHeader('Connection', 'close');
        req.send(null);
        document.getElementById(div).innerHTML = req.responseText;
        if (document.getElementById("loading") != null )
            document.getElementById("loading").innerHTML="";
    }
}

function addOption(listSend, listReceive, hiddenName) {
    var index = listSend.selectedIndex;
    if (index > 0) {
        var subject = trim(listSend.options[index].value);
        listSend.remove(index);

        var option = document.createElement("option");
        option.setAttribute("value",subject);

        repaintOptions(listSend,0);

        if(hiddenName == 'bookTitle'){
            listReceive.remove(0);
            document.getElementById(hiddenName).value = subject + ';';
        }else{
            document.getElementById(hiddenName).value += subject + ';';
        }
        
        option.text = subject;
        listReceive.appendChild(option);
        repaintOptions(listReceive,1);
    }
}

function removeOption(listSend, listReceive, hiddenName) {
    var index = 0;
    index = listSend.selectedIndex;
    if (index > -1) {
        var subject = trim(listSend.options[index].value);

        var subjects = document.getElementById(hiddenName).value;
        subjects = subjects.split(';');
        document.getElementById(hiddenName).value = "";

        if(hiddenName == 'bookTitle'){
            document.getElementById(hiddenName).value = '';
            alert(document.getElementById(hiddenName).value);
        }else{
            for (i = 0; i < subjects.length - 1; i++){
                if(subjects[i] != subject){
                    document.getElementById(hiddenName).value += subjects[i] + ';';
                }
            }
        }

        var option = document.createElement("option");
        option.setAttribute("value",subject);
        option.text = subject;
        listReceive.appendChild(option);
        repaintOptions(listReceive,0);
        
        listSend.remove(index);
        repaintOptions(listSend,1);
    }
}

function repaintOptions(list, first){
    var i = 0;
    var option;
    var num;

    switch (first) {
        case 0:
            num = 1;
            break;
        case 1:
            num = 0;
    }

    for (i = num; i < list.length; i++) {
        option = list.options[i];
        if (i % 2 == 0) {
            option.setAttribute("style", "background-color: #ffffff");
        } else {
            option.setAttribute("style", "background-color: #dddddd");
        }
    }
}

function callServletPublication(selectedIndex){
    if(selectedIndex != -1){
        var profile =  document.getElementById("profileUser").value;
        if(selectedIndex == 0){
            if(profile != 0){
                callServlet('PublicationMaintenance?action=Consult&index=' + selectedIndex , 'AjaxContent');
            }else{
                callServlet('PublicationMaintenance?action=Consult&index=' + selectedIndex , 'publication_data');
            }
        }else{
            callServlet('PublicationMaintenance?action=Consult&index=' + selectedIndex , 'publication_data');
        }
    }
}

function ltrim(texto) {
    return texto.replace(/^[ ]+/, '');
}

function rtrim(texto) {
    return texto.replace(/[ ]+$/, '');
}

function trim(texto) {
    return ltrim(rtrim(texto));
}

function validateFormPublication(action){
    
    var messagePublication = "";
    var formPublication = document.getElementById("formPublication");

    // expressões regulares
    var expRegNumber=/[0-9]{1,8}/;

    var url;
    var authorsParameter

    if(action == 'savePublication'){
        url  = "PublicationMaintenance?action=savePublication";
        authorsParameter = trim(formPublication.author.value);
    }else{
        url = "PublicationMaintenance?action=updatePublication";
    }

    var title = trim(formPublication.title.value);
    if (title == ""){
        messagePublication += ("<p>- <strong>Title</strong> is required!</p>");
        formPublication.title.focus();
    }

    var typePublication = trim(document.getElementById("typePublication").value);
    
    switch (typePublication) {
        case "phdThesis":
            break;
        case "mastersThesis":
            break;
        case "inprocedings":
            break;
        case "book":
            break;
        case "incollection":
            break;
        case "www":
            break;
        case "article":
            var startPage = trim(formPublication.startPage.value);
            if( startPage != "" && startPage.match(expRegNumber) == null){
                messagePublication += ("<p>- <strong>Start Page</strong> must be a number!</p>");
                formPublication.startPage.focus();
            }

            var endPage = trim(formPublication.endPage.value);
            if( endPage != "" && endPage.match(expRegNumber) == null){
                messagePublication += ("<p>- <strong>End Page</strong> must be a number!</p>");
                formPublication.endPage.focus();
            }

            var volume = trim(formPublication.volume.value);
            if( volume != "" && volume.match(expRegNumber) == null){
                messagePublication += ("<p>- <strong>Volume</strong> must be a number!</p>");
                formPublication.volume.focus();
            }

            var number = trim(formPublication.number.value);
            if( number != "" && number.match(expRegNumber) == null){
                messagePublication += ("<p>- <strong>Number</strong> must be a number!</p>");
                formPublication.number.focus();
            }

            var cdrom = trim(formPublication.cdrom.value);
            var journal = trim(formPublication.journal.value);
            var note = trim(formPublication.note.value);
            var month = trim(formPublication.month.value);
            var ee = trim(formPublication.ee.value);
            var urlField = trim(formPublication.url.value);
            
            if(action == 'savePublication'){
                var bookTitleParameter = trim(formPublication.bookTitle.value);
                url += "&typePublication=article&title=" + title + "&cdrom=" + cdrom + "&journal=" + journal + "&note=" + note + "&month=" + month +
                "&ee=" + ee + "&url=" + urlField + "&startPage=" + startPage + "&endPage=" + endPage + "&volume=" + volume +
                "&number=" + number + "&author=" + authorsParameter + "&bookTitle=" + bookTitleParameter;
            }else{
                url += "&typePublication=article&title=" + title + "&cdrom=" + cdrom + "&journal=" + journal + "&note=" + note + "&month=" + month +
                "&ee=" + ee + "&url=" + urlField + "&startPage=" + startPage + "&endPage=" + endPage + "&volume=" + volume +
                "&number=" + number + "&index=" + trim(formPublication.indexSelected.value);
            }
            break;
        case "proceedings":
            break;
    }

    if(messagePublication != ""){
        messagePublication += "<p>- Click on the box to close it.</p>";
        showMessage('critical', messagePublication);
        return false;
    }

    callServlet(url, "AjaxContent");
    return true;
}

function deletePublication(){
    var url  = "PublicationMaintenance?action=deletePublication&index="+trim(document.getElementById("indexSelected").value);
    callServlet(url, "AjaxContent");
}

function validateFormContato(){
    formContact = document.getElementById("formContato");
    var message = "";
    
    if(formContact.email.value == ""){
        message += ("<p>- <strong>Email</strong> is required!</p>");
        formContact.email.focus();
    }

    var email = formContact.email.value;
    if (email != ""){
        if( email.match( /[a-z|A-Z|0-9]{2,8}@[a-z|A-Z|0-9]{2,8}\.[a-z]{3}([\.]{1}[a-z]{2})*/ ) == null ){
            message += ("<p>- <strong>Email</strong> is in incorrect format!</p>");
            formContact.email.focus();
        }
    }

    if(formContact.comentario.value.toString() == ""){
        message += ("<p>- <strong>Message</strong> is required!</p>");
        formContact.comentario.focus();
    }

    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    var urlContact = "SendEmail?nome="+formContact.nome.value+"&email=" + formContact.email.value+"&assunto="+formContact.assunto.value+"&comentario="+formContact.comentario.value;
    callServlet(urlContact, "AjaxContent");
    return true;
}

function validateFormBusca(){
    form = document.getElementById("formBusca");

    var message = "";
    if (form.parametro.value == ""){
        message += "<p>- <strong>Search parameter</strong> is required!</p>";
        form.parametro.focus();
        return false;
    }

    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    var url = "Search?action=doSearch&parametro="+form.parametro.value+"&filtro=" + form.filtro.value;

    callServlet(url, "AjaxContent");
    return true;

}

function validateFormEvent(){
    alert("entrouu");
    form = document.getElementById("formEvent");
    var message = "";

    var name = form.name.value;
    var local = form.city.value;
    var startDate = form.startDate.value;
    var endDate = form.endDate.value;

    if (name == ""){
        message += ("<p>- <strong>Name</strong> is required!</p>");
        form.name.focus();
    }

    if (local == ""){
        local = "null";
    }

    if (startDate == ""){
        startDate = "null";
    }

    if (endDate == ""){
        endDate = "null";
    }

    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    var url = "EventMaintenance?action=save&name=" + form.name.value + "&city=" + form.city.value +
    "&startDate=" + form.startDate.value + "&endDate=" + form.endDate.value;
    
    callServlet(url, "AjaxContent");
    return true;
}

function closeMessageBox(){
    if (document.getElementById("msg") != null )
        document.getElementById("msg").innerHTML="";
}

function updateUpgrade(login, mode) {
    var url = "MaintenanceUserData?action=";

    switch (mode) {
        case 1:
            url += "allowUpgrade&";
            break;

        default:
            url += "denyUpgrade&";
            break;

    }
    url += "login=" + login;

    callServlet(url, "AjaxContent");
}

function validateFormPost(publication, login, text, position){
    var message = "";

    if (text == ""){
        message = "<fieldset class=\"critical\" onclick=\"closeMessageBox()\">";
        message += ("<p>- <strong>Comment</strong> is required!</p>");
        message += ("<p>- Click on the box to close it.</p>");

        document.getElementById("msg").innerHTML = message;

        document.getElementById('comment').focus();
    } else if (text.match(/^[ \t]+|[ \t]+$/)){
        message = "<fieldset class=\"critical\" onclick=\"closeMessageBox()\">";
        message += ("<p>- <strong>Comment</strong> can not be blank!</p>");
        message += ("<p>- Click on the box to close it.</p>");

        document.getElementById("msg").innerHTML = message;
        document.getElementById('comment').value = '';
        document.getElementById('comment').focus();
    } else {
        var url = "PublicationMaintenance?action=managePost&publication=" + publication + "&";
        url    += "login=" + login;
        url    += "&text=" + text;
        url    += "&position=" + position;
        url    += "&mode=1";
        callServlet(url, "AjaxContent");
    }

}

function blockTyping(valor)
{
    quant = 140;
    total = valor.length;
    var message = "";

    if(total <= quant)
    {
        if (total > 0) {
            resto = quant - total;
            document.getElementById('count').innerHTML = "<strong>" + resto + "</strong> characters are missing";
        } else {
            document.getElementById('count').innerHTML = "<strong>" + quant + "</strong> characters are missing";
        }
        message = "<fieldset class=\"information\" onclick=\"closeMessageBox()\">";
        message += "<legend>Information</legend>";
        message += "<p>- All fields with (*) are required.</p>";
        message += "<p>- Click on the box to close it.</p>";
        message += "</fieldset>";
    }
    else
    {
        message = "<fieldset class=\"warning\" onclick=\"closeMessageBox()\">";
        message += "<legend>Warning</legend>";
        message += "<p>- Your <strong>comment</strong> has been <strong>truncated</strong> to 140 characters.</p";
        message += "<p>- All fields with (*) are required.</p>";
        message += "<p>- Click on the box to close it.</p>";
        message += "</fieldset>";
        document.getElementById('comment').value = document.getElementById('comment').value = document.getElementById('comment').value = document.getElementById('comment').value.substr(0,quant);
    }

    document.getElementById('msg').innerHTML = message;
    document.getElementById('comment').focus();
}

function validateFormInsertTheme(){
    form = document.getElementById("formInsertTheme");
    var message = "";
    if(form.newTheme.value == ""){
        message += ("<p>- <strong>Theme</strong> is required!</p>");
        form.newTheme.focus();
    }
    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }
    var url = "Settings?newTheme=" + form.newTheme.value + "&mode=newtheme";

    callServlet(url, "AjaxContent");
    return true;
}

function validateFormInsertUpgrade(){
    form = document.getElementById("formInsertUpgrade");
    var message = "";
    if(form.newMaxUpgrade.value == ""){
        message += ("<p>- <strong>Maximum number</strong> of <strong>upgrade requests</strong> is required!</p>");
        form.newMaxUpgrade.focus();
    }

    var max = form.newMaxUpgrade.value;
    if(max.match(/^[1-9][0-9]*/) == null ){
        message += ("<p>- <strong>Maximum number</strong> of <strong>upgrade requests</strong> must be an integer positive number!</p>");
        form.newMaxUpgrade.focus();
    }


    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    var url = "Settings?newMaxUpgrade=" + form.newMaxUpgrade.value + "&mode=upgrade";


    callServlet(url, "AjaxContent");
    return true;
}
