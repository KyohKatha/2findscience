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
        document.getElementById("loading").innerHTML = "<div style=\"position: relative;left: 48px;top: 76px;font-family: tahoma,sans-serif;\">Loading. Please wait...</div>";
        document.getElementById("loading").style.visibility = 'visible';
    }
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState==4 && xmlhttp.status == 200) {
            document.getElementById(div).innerHTML=xmlhttp.responseText;
            if (document.getElementById("loading") != null )
                document.getElementById("loading").style.visibility = 'hidden';
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
    if(acao != "save"){
        var password = trim(form.password.value);
        var passwordConfirmation = trim(form.passwordConfirmation.value);
    }
    var email = trim(form.email.value);
    var page = trim(form.page.value);

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
        if( email.match( /[a-z|A-Z|0-9|._]{2,8}@[a-z|A-Z|0-9]{2,20}\.[a-z]{3}([\.]{1}[a-z]{2})*/ ) == null ){
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

    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    if(acao != "save")
        var subjectsParameter = document.getElementById("options").value;
    var url;

    if(acao == "Register"){
        url = "MaintenanceUserData?action=saveRegister&login=" + trim(login) + "&password=" + trim(password) +
        "&name=" + trim(name) + "&email=" + trim(email) + "&page=" + trim(page) + "&subjects=" +  trim(subjectsParameter);
    }else if(acao == "save"){
        url = "MaintenanceUserData?action=save&login=" + trim(form.login.value) + "&name=" + trim(form.name.value) + "&email=" + trim(form.email.value) + "&page=" + trim(form.page.value) + "&profile=" + trim(form.profile.value);
    }else{
        url = "MaintenanceUserData?action=updateProfile&profile=" + trim(form.profile.value) + "&login=" + trim(login) + "&password=" + trim(password) +
        "&name=" + trim(name) + "&email=" + trim(email) + "&page=" + trim(page) + "&subjects=" +  trim(subjectsParameter);
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
        document.getElementById("loading").innerHTML="<div style=\"position: relative;left: 48px;top: 76px;font-family: tahoma,sans-serif;\">Loading. Please wait...</div>";
        document.getElementById("loading").style.visibility = 'visible';
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
            document.getElementById("loading").style.visibility = 'hidden';
    }
}

function addOption(listSend, listReceive, nameOption) {

    var index = listSend.selectedIndex;
    if (index > 0) {
        var subject = trim(listSend.options[index].value);
        listSend.remove(index);

        var option = document.createElement("option");
        option.setAttribute("value",subject);

        repaintOptions(listSend,0);

        if(nameOption == 'BookTitle'){
            listReceive.remove(0);
            document.getElementById("options").value = subject + ';';
        }else{
            document.getElementById("options").value += subject + ';';
        }

        option.text = subject;
        listReceive.appendChild(option);
        repaintOptions(listReceive,1);
    }
}

function removeOption(listSend, listReceive, nameOption) {

    var index = 0;
    index = listSend.selectedIndex;
    if (index > -1) {
        var subject = trim(listSend.options[index].value);

        var subjects = document.getElementById("options").value;
        subjects = subjects.split(';');
        document.getElementById("options").value = "";

        if(nameOption == 'BookTitle'){
            document.getElementById("options").value = '';
        }else{
            for (i = 0; i < subjects.length - 1; i++){
                if(subjects[i] != subject){
                    document.getElementById("options").value += subjects[i] + ';';
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

    // expressÃµes regulares
    var expRegNumber=/[0-9]{1,8}/;

    var title = trim(formPublication.title.value);
    if (title == ""){
        messagePublication += ("<p><strong>- Title</strong> is required!</p>");
        formPublication.title.focus();
    }

    var typePublication = trim(document.getElementById("typePublication").value);
    var urlField = trim(formPublication.url.value);
    var url, school, cdrom, number, volume, journal, note, month, ee, startPage, endPage, isbn, chapter, address;
    var booktitle, editor, publisher, authors;

    if(action == 'savePublication'){
        authors = trim(formPublication.author.value);
        authors = authors.toString().replace(" ", "+");
        url  = "PublicationMaintenance?action=savePublication";
        if(typePublication != "phdthesis" && typePublication != "mastersthesis"){
            booktitle = trim(formPublication.booktitle.value);
            editor = trim(formPublication.editor.value);
            publisher = trim(formPublication.publisher.value);
            booktitle = booktitle.toString().replace(" ", "+");
            editor = editor.toString().replace(" ", "+");
            publisher = publisher.toString().replace(" ", "+");
            url += "&title=" + title + "&url=" + urlField + "&author=" + authors + "&booktitle=" + booktitle +
            "&editor=" + editor + "&publisher=" + publisher;
        }else{
            url += "&title=" + title + "&url=" + urlField + "&author=" + authors;
        }
    }else{ /*Update publication*/

        url = "PublicationMaintenance?action=updatePublication&title=" + title + "&url=" + urlField;
    }

    switch (typePublication) {
        case "phdthesis":
            school = trim(formPublication.school.value);
            number = trim(formPublication.number.value);
            volume = trim(formPublication.volume.value);
            month = trim(formPublication.month.value);
            ee = trim(formPublication.ee.value);
            isbn = trim(formPublication.isbn.value);

            if( volume != "" && volume.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Volume</strong> must be number!</p>");
                formPublication.volume.focus();
            }

            if( number != "" && number.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Number</strong> must be number!</p>");
                formPublication.number.focus();
            }
            url += "&typePublication=phdthesis&school=" + school + "&number=" + number + "&volume=" + volume + "&month=" +
            month + "&ee=" + ee + "&isbn=" + isbn;

            break;
        case "mastersthesis":
            school = trim(formPublication.school.value);
            url += "&typePublication=mastersthesis&school=" + school;
            break;
        case "inproceedings":
            ee = trim(formPublication.ee.value);
            startPage = trim(formPublication.startPage.value);
            endPage = trim(formPublication.endPage.value);
            cdrom = trim(formPublication.cdrom.value);
            note = trim(formPublication.note.value);
            number = trim(formPublication.number.value);
            month = trim(formPublication.month.value);

            if( startPage != "" && startPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Start Page</strong> must be number!</p>");
                formPublication.startPage.focus();
            }

            if( endPage != "" && endPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- End Page</strong> must be number!</p>");
                formPublication.endPage.focus();
            }

            if( number != "" && number.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Number</strong> must be number!</p>");
                formPublication.number.focus();
            }

            url += "&typePublication=inprocedings&ee=" + ee + "&startPage=" + startPage + "&endPage=" + endPage +
            "&cdrom=" + cdrom + "&note=" + note + "&number=" + number + "&month=" + month;

            break;
        case "book":
            ee = trim(formPublication.ee.value);
            volume = trim(formPublication.volume.value);
            cdrom = trim(formPublication.cdrom.value);
            month = trim(formPublication.month.value);
            isbn = trim(formPublication.isbn.value);

            if( volume != "" && volume.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Volume</strong> must be number!</p>");
                formPublication.volume.focus();
            }

            url += "&typePublication=book&ee=" + ee + "&volume=" + volume + "&cdrom=" + cdrom +
            "&month=" + month + "&isbn=" + isbn;

            break;
        case "incollection":
            ee = trim(formPublication.ee.value);
            startPage = trim(formPublication.startPage.value);
            endPage = trim(formPublication.endPage.value);
            cdrom = trim(formPublication.cdrom.value);
            chapter = trim(formPublication.chapter.value);
            isbn = trim(formPublication.isbn.value);

            if( startPage != "" && startPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Start Page</strong> must be number!</p>");
                formPublication.startPage.focus();
            }

            if( endPage != "" && endPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- End Page</strong> must be number!</p>");
                formPublication.endPage.focus();
            }

            if( chapter != "" && chapter.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Chapter</strong> must be number!</p>");
                formPublication.chapter.focus();
            }

            url += "&typePublication=incollection&ee=" + ee + "&startPage=" + startPage + "&endPage=" + endPage +
            "&cdrom=" + cdrom + "&chapter=" + chapter + "&isbn=" + isbn;

            break;
        case "www":
            ee = trim(formPublication.ee.value);
            note = trim(formPublication.note.value);

            url += "&typePublication=www&ee=" + ee + "&note=" + note;
            break;
        case "article":
            cdrom = trim(formPublication.cdrom.value);
            journal = trim(formPublication.journal.value);
            note = trim(formPublication.note.value);
            month = trim(formPublication.month.value);
            ee = trim(formPublication.ee.value);
            startPage = trim(formPublication.startPage.value);
            endPage = trim(formPublication.endPage.value);
            volume = trim(formPublication.volume.value);
            number = trim(formPublication.number.value);

            if( startPage != "" && startPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Start Page</strong> must be number!</p>");
                formPublication.startPage.focus();
            }

            if( endPage != "" && endPage.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- End Page</strong> must be number!</p>");
                formPublication.endPage.focus();
            }

            if( volume != "" && volume.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Volume</strong> must be number!</p>");
                formPublication.volume.focus();
            }

            if( number != "" && number.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Number</strong> must be number!</p>");
                formPublication.number.focus();
            }

            url += "&typePublication=article&cdrom=" + cdrom + "&journal=" + journal + "&note=" + note + "&month=" + month +
            "&ee=" + ee + "&startPage=" + startPage + "&endPage=" + endPage + "&volume=" + volume +
            "&number=" + number;
            break;
        case "proceedings":
            ee = trim(formPublication.ee.value);
            journal = trim(formPublication.journal.value);
            volume = trim(formPublication.volume.value);
            number = trim(formPublication.number.value);
            note = trim(formPublication.note.value);
            month = trim(formPublication.month.value);
            address = trim(formPublication.address.value);
            isbn = trim(formPublication.isbn.value);


            if( volume != "" && volume.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Volume</strong> must be number!</p>");
                formPublication.volume.focus();
            }

            if( number != "" && number.match(expRegNumber) == null){
                messagePublication += ("<p><strong>- Number</strong> must be number!</p>");
                formPublication.number.focus();
            }

            url += "&typePublication=proceedings&ee=" + ee + "&journal=" + journal +
            "&volume=" + volume + "&number=" + number + "&note=" + note + "&month=" + month +
            "&address=" + address + "&isbn=" + isbn;

            break;
    }

    if(messagePublication != ""){
        showMessage('critical', messagePublication);
        return false;
    }

    if(action != 'savePublication'){
        url += "&index=" + trim(formPublication.indexSelected.value);
    }
    alert(url);
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
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        form.parametro.focus();
        return false;
    }

    var url = "Search?action=doSearch&parametro="+form.parametro.value+"&filtro=" + form.filtro.value;

    callServlet(url, "AjaxContent");
    return true;

}

function validateFormEvent(mode){
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

    if(message != ""){
        message += "<p>- Click on the box to close it.</p>";
        showMessage('critical', message);
        return false;
    }

    var url;
    if(mode == "update"){
        var cod = document.getElementById("codBookTitle").value;
         url = "EventMaintenance?action=save&cod=" + cod + "&name=" + name + "&city=" + local +
        "&startDate=" + startDate + "&endDate=" + endDate;
    }else{
       url = "EventMaintenance?action=save&cod=0&name=" + name + "&city=" + local +
        "&startDate=" + startDate + "&endDate=" + endDate;
    }

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

function callEventInsert(index){
    var sDate;
    var eDate;

    callServlet('EventMaintenance?action=show&index=' + index,'events_data');

    if (index == 0){
        sDate = null;
        eDate = null;
    } else {
        sDate = document.getElementById("startDateHidden").value;
        eDate = document.getElementById("endDataHidden").value;
    }

    var period = new Array();
    period[0] = sDate;
    period[1] = eDate;

    document.getElementById('startDate').value = period[0];
    document.getElementById('endDate').value = period[1];

    window.addEvent('domready', function() {
        var startDate = new CalendarEightysix('startDate', {
            'disallowUserInput': true,
            'alignX': 'left',
            'alignY': 'bottom',
            'offsetX': -4 ,
            'theme': 'vista',
            'inputOutputFormat' : 'Y/m/d'
        });
        var endDate = new CalendarEightysix('endDate', {
            'disallowUserInput': true,
            'alignX': 'left',
            'alignY': 'bottom',
            'offsetX': -4,
            'theme': 'vista'
        });
       startDate.addEvent('change', function(date) {
            date = date.clone().increment();
            endDate.options.minDate = date;
           if(endDate.getDate().diff(date) >= 1) endDate.setDate(date);
            else endDate.render();
        })
    });


}

/***************POPUP*********************/

var Nav4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 4))

var dialogWin = new Object()

var optionPopUp;

function openDGDialog(mode, url, width, height, returnFunc, args) {
    if (document.getElementById("loading") != null ){
        document.getElementById("loading").innerHTML="<div style=\"position: relative;left: 48px;top: 76px;font-family: tahoma,sans-serif;\">Loading. Please wait...</div>";
        document.getElementById("loading").style.visibility = 'visible';
    }
    setPopUp(mode);
    optionPopUp = mode;
    if (!dialogWin.win || (dialogWin.win && dialogWin.win.closed)) {
        dialogWin.returnFunc = returnFunc
        dialogWin.returnedValue = ""
        dialogWin.args = args
        dialogWin.url = url
        dialogWin.width = width
        dialogWin.height = height
        dialogWin.name = (new Date()).getSeconds().toString()
        if (Nav4) {
            dialogWin.left = window.screenX +
            ((window.outerWidth - dialogWin.width) / 2)
            dialogWin.top = window.screenY +
            ((window.outerHeight - dialogWin.height) / 2)
            var attr = "screenX=" + dialogWin.left +
            ",screenY=" + dialogWin.top + ",resizable=no,width=" +
            dialogWin.width + ",height=" + dialogWin.height
        } else {
            dialogWin.left = (screen.width - dialogWin.width) / 2
            dialogWin.top = (screen.height - dialogWin.height) / 2
            var attr = "left=" + dialogWin.left + ",top=" +
            dialogWin.top + ",resizable=no,width=" + dialogWin.width +
            ",height=" + dialogWin.height
        }

        dialogWin.win=window.open(dialogWin.url, dialogWin.name, attr)
        dialogWin.win.focus()
    } else {
        dialogWin.win.focus()
    }
    if (document.getElementById("loading") != null )
        document.getElementById("loading").style.visibility = 'hidden';
}

function checkModal() {
    setTimeout("finishChecking()", 50)
    return true
}

function finishChecking() {
    if (dialogWin.win && !dialogWin.win.closed) {
        dialogWin.win.focus()
    }
}

function setPrefs() {
    document.getElementById(optionPopUp).value =  dialogWin.returnedValue;
}

function setPopUp(mode){
    HttpMethod = "POST";
    var req = null;
    var urlPopUp = "Filter?action=popupInsert&mode=" + mode;
    req = getXMLHTTPRequest();
    if (req){
        req.open(HttpMethod,urlPopUp,false);
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.setRequestHeader('Connection', 'close');
        req.send(null);
        req.responseText;
        if (document.getElementById("loading") != null )
            document.getElementById("loading").innerHTML="";
    }

}