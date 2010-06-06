<%-- 
    Document   : popupCalendar
    Created on : 03/06/2010, 01:30:07
    Author     : Kaori
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calendar</title>


        <script type="text/javascript" src="AjaxSimple.js"></script>
        <script type="text/javascript" src="js/mootools-1.2.4-core.js"></script>
        <script type="text/javascript" src="js/mootools-1.2.4.4-more.js"></script>
        <script type="text/javascript" src="js/calendar-eightysix-v1.1.js"></script>
        <link type="text/css" media="screen" href="css/calendar-eightysix-v1.1-vista.css" rel="stylesheet" />

        <script type="text/javascript">

            var period = window.dialogArguments;

            window.addEvent('domready', function() {
                var startDate = new CalendarEightysix('startDate', { 'disallowUserInput': true, 'minDate': 'today',  'alignX': 'left',
                    'alignY': 'bottom', 'offsetX': -4 , 'theme': 'vista', 'inputOutputFormat' : 'Y/m/d' });
                var endDate = new CalendarEightysix('endDate', { 'disallowUserInput': true, 'minDate': 'tomorrow', 'alignX': 'left', 
                    'alignY': 'bottom', 'offsetX': -4, 'theme': 'vista'});
                startDate.addEvent('change', function(date) {
                        date = date.clone().increment(); //At least one day higher; so increment with one day
                        endDate.options.minDate = date; //Set the minimal date
                        if(endDate.getDate().diff(date) >= 1) endDate.setDate(date); //If the current date is lower change it
                        else endDate.render(); //Always re-render
                })
            });


            function fillDate(){
                document.getElementById('startDate').value = period[0];
                document.getElementById('endDate').value = period[1];
            }

            </script>
    </head>
    <body onload="fillDate()">
        <table class="maintenance" align="center" cellspacing="15px">
            <tr>
                <td>Start Date </td>
                <td><input type="text" id="startDate" name="startDate" size="30" maxlength="30"/></td>
            </tr>
            <tr>
                <td>End Date </td>
                <td><input type="text" id="endDate" name="endDate" size="30" maxlength="30"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="buttonsbox">
                        <input type="button" class="button" value="Save" name="save" onclick="saveDate()"/>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>
