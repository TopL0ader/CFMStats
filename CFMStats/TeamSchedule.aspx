﻿<%@ Page Title="Team Schedule" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamSchedule.aspx.cs" Inherits="CFMStats.TeamSchedule" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .ChkBoxClass {
            font-size: 1.2em;
            margin: 7px;
        }

            .ChkBoxClass input {
                width: 28px;
                height: 28px;
                margin-right: 5px;
            }
    </style>

    <div class="container">

        <div class="row">
            <div class="col-xs-6 col-sm-3">
                <asp:DropDownList ID="ddlSeasonType" runat="server" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlLeagueTeams_SelectedIndexChanged">
                    <asp:ListItem Text="Regular" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Pre" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>


            <div class="col-xs-6 col-sm-6">
                <asp:DropDownList ID="ddlSeason" runat="server" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlLeagueTeams_SelectedIndexChanged"></asp:DropDownList>
            </div>

            <div class="col-xs-12 col-sm-3">
                <div class="visible-xs">
                    <br />
                </div>
                <div class="input-group input-group-sm">
                    <asp:DropDownList ID="ddlLeagueTeams" runat="server" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlLeagueTeams_SelectedIndexChanged"></asp:DropDownList>

                    <span class="input-group-btn">
                        <button type="button" name="btnPrevStatus" value="Previous" class="btn btn-default" onclick="Previous(this,'<%= ddlLeagueTeams.ClientID %>');" id="btnPrevStatus">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                        </button>

                        <button type="button" class="btn btn-default" name="btnNextStatus" value="Next" onclick="Next(this,'<%= ddlLeagueTeams.ClientID %>');" id="btnNextStatus">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                        </button>
                    </span>
                </div>

            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-sm-12">

                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div style="text-align: center;">
                            <label class="label label-warning">... LOADING ...</label>
                            <label class="label label-danger">... LOADING ...</label>
                            <label class="label label-success">... LOADING ...</label><br />
                        </div>
                        <br />
                    </ProgressTemplate>
                </asp:UpdateProgress>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="table-responsive table-bordered-curved">

                            <div id="tblSchedule" runat="server" visible="true"></div>
                        </div>



                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlLeagueTeams" EventName="SelectedIndexChanged" />


                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Development</h4>
                </div>
                <div class="modal-body">
                    <h3><strong>Slow</strong></h3>
                    will return Slow, Normal, Quick and Superstar players<br />
                    <h3><strong>Normal</strong></h3>
                    will return Normal, Quick and Superstar players<br />
                    <h3><strong>Quick</strong></h3>
                    will return Quick and Superstar players<br />
                    <h3><strong>Superstar</strong></h3>
                    will return Superstar players<br />

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->



    <%-- tablesorter --%>

    <link href="../Content/tablesorter/theme.ice.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery.tablesorter.min.js"></script>
    <script src="../Scripts/jquery.tablesorter.widgets.min.js"></script>
    <link href="../Content/tablesorter/jquery.tablesorter.pager.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery.tablesorter.pager.min.js"></script>
    <%--<script src="../Scripts/jquery.stickytableheaders.min.js"></script>--%>

    <script>



        //Initial bind
        $(document).ready(function () {
            BindControlEvents();
        });

        //Re-bind for callbacks
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            BindControlEvents();
        });


        function BindControlEvents() {
            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            })


            //$(function () {
            //    var mc = {
            //        '0-50': 'lowRating',
            //        '51-89': 'mediumRating',
            //        '90-100': 'highRating'
            //    };

            //    function between(x, min, max) {
            //        return x >= min && x <= max;
            //    }



            //    var dc;
            //    var first;
            //    var second;
            //    var th;

            //    $('td').each(function (index) {

            //        th = $(this);

            //        dc = parseInt($(this).attr('data-color'), 10);


            //        $.each(mc, function (name, value) {


            //            first = parseInt(name.split('-')[0], 10);
            //            second = parseInt(name.split('-')[1], 10);

            //            console.log(between(dc, first, second));

            //            if (between(dc, first, second)) {
            //                th.addClass(value);
            //            }



            //        });

            //    });
            //})

            //$(function () {
            //    $('#myModal').modal();
            //})
            //var offset = $('.navbar').height();
            //$("html:not(.legacy) table").stickyTableHeaders({ fixedOffset: offset });

            var $table = $('#sumtable');
            $('#reset-link').click(function () {
                $table.trigger('filterReset').trigger('sortReset');
                return false;
            });

            $("table").tablesorter({
                theme: 'ice',

                // fix the column widths
                widthFixed: true,

                // Show an indeterminate timer icon in the header when the table
                // is sorted or filtered
                showProcessing: true,

                // header layout template (HTML ok); {content} = innerHTML,
                // {icon} = <i/> (class from cssIcon)
                headerTemplate: '{content}',

                // return the modified template string
                onRenderTemplate: null, // function(index, template){ return template; },

                // called after each header cell is rendered, use index to target the column
                // customize header HTML
                onRenderHeader: function (index) {
                    // the span wrapper is added by default
                    $(this).find('div.tablesorter-header-inner').addClass('roundedCorners');
                },

                // *** FUNCTIONALITY ***
                // prevent text selection in header
                cancelSelection: true,

                // other options: "ddmmyyyy" & "yyyymmdd"
                dateFormat: "mmddyyyy",

                // The key used to select more than one column for multi-column
                // sorting.
                sortMultiSortKey: "shiftKey",

                // key used to remove sorting on a column
                sortResetKey: 'ctrlKey',

                // false for German "1.234.567,89" or French "1 234 567,89"
                usNumberFormat: true,

                // If true, parsing of all table cell data will be delayed
                // until the user initializes a sort
                delayInit: true,

                // if true, server-side sorting should be performed because
                // client-side sorting will be disabled, but the ui and events
                // will still be used.
                serverSideSorting: false,

                // *** SORT OPTIONS ***
                // These are detected by default,
                // but you can change or disable them
                // these can also be set using data-attributes or class names
                headers: {
                    // set "sorter : false" (no quotes) to disable the column
                    0: {
                        sorter: "text"
                    },
                    1: {
                        sorter: "digit"
                    },
                    2: {
                        sorter: "text"
                    },
                    3: {
                        sorter: "url"
                    }
                },

                // ignore case while sorting
                ignoreCase: true,

                // forces the user to have this/these column(s) sorted first
                sortForce: null,
                // initial sort order of the columns, example sortList: [[0,0],[1,0]],
                // [[columnIndex, sortDirection], ... ]
                sortList: [
                    [6, 1]
                ],
                // default sort that is added to the end of the users sort
                // selection.
                sortAppend: null,

                // starting sort direction "asc" or "desc"
                sortInitialOrder: "desc",

                // Replace equivalent character (accented characters) to allow
                // for alphanumeric sorting
                sortLocaleCompare: false,

                // third click on the header will reset column to default - unsorted
                sortReset: true,

                // restart sort to "sortInitialOrder" when clicking on previously
                // unsorted columns
                sortRestart: true,

                // sort empty cell to bottom, top, none, zero
                emptyTo: "bottom",

                // sort strings in numerical column as max, min, top, bottom, zero
                stringTo: "max",

                // extract text from the table - this is how is
                // it done by default
                //textExtraction: {
                //    0: function (node) {
                //        return $(node).text();
                //    },
                //    1: function (node) {
                //        return $(node).text();
                //    }
                //},

                // use custom text sorter
                // function(a,b){ return a.sort(b); } // basic sort
                textSorter: null,

                // *** WIDGETS ***

                // apply widgets on tablesorter initialization
                initWidgets: true,

                // include zebra and any other widgets, options:
                // 'columns', 'filter', 'stickyHeaders' & 'resizable'
                // 'uitheme' is another widget, but requires loading
                // a different skin and a jQuery UI theme.
                widgets: ['zebra', 'columns', 'filter', 'saveSort', 'resizeable'],

                widgetOptions: {

                    // zebra widget: adding zebra striping, using content and
                    // default styles - the ui css removes the background
                    // from default even and odd class names included for this
                    // demo to allow switching themes
                    // [ "even", "odd" ]
                    zebra: [
                        "ui-widget-content even",
                        "ui-state-default odd"],

                    // uitheme widget: * Updated! in tablesorter v2.4 **
                    // Instead of the array of icon class names, this option now
                    // contains the name of the theme. Currently jQuery UI ("jui")
                    // and Bootstrap ("bootstrap") themes are supported. To modify
                    // the class names used, extend from the themes variable
                    // look for the "$.extend($.tablesorter.themes.jui" code below
                    //  uitheme: 'jui',

                    // columns widget: change the default column class names
                    // primary is the 1st column sorted, secondary is the 2nd, etc
                    columns: [
                        "primary",
                        "secondary",
                        "tertiary"],

                    // filter widget: If true, a filter will be added to the top of
                    // each table column.
                    filter_columnFilters: true,

                    // filter widget: css class applied to the table row containing the
                    // filters & the inputs within that row
                    filter_cssFilter: "form-control input-sm",

                    // filter widget: Customize the filter widget by adding a select
                    // dropdown with content, custom options or custom filter functions
                    // see http://goo.gl/HQQLW for more details
                    filter_functions: null,

                    // filter widget: Set this option to true to hide the filter row
                    // initially. The rows is revealed by hovering over the filter
                    // row or giving any filter input/select focus.
                    filter_hideFilters: false,

                    // filter widget: Set this option to false to keep the searches
                    // case sensitive
                    filter_ignoreCase: true,

                    // filter widget: jQuery selector string of an element used to
                    // reset the filters.
                    filter_reset: null,

                    // Delay in milliseconds before the filter widget starts searching;
                    // This option prevents searching for every character while typing
                    // and should make searching large tables faster.
                    filter_searchDelay: 750,

                    // Set this option to true if filtering is performed on the server-side.
                    filter_serversideFiltering: false,

                    // filter widget: Set this option to true to use the filter to find
                    // text from the start of the column. So typing in "a" will find
                    // "albert" but not "frank", both have a's; default is false
                    filter_startsWith: false,

                    // filter widget: If true, ALL filter searches will only use parsed
                    // data. To only use parsed data in specific columns, set this option
                    // to false and add class name "filter-parsed" to the header
                    filter_useParsedData: false,


                    // saveSort widget: If this option is set to false, new sorts will
                    // not be saved. Any previous saved sort will be restored on page
                    // reload.
                    saveSort: true

                },

                // *** CALLBACKS ***
                // function called after tablesorter has completed initialization
                initialized: function (table) { },

                // *** CSS CLASS NAMES ***
                tableClass: 'tablesorter',
                cssAsc: "tablesorter-headerSortUp",
                cssDesc: "tablesorter-headerSortDown",
                cssHeader: "tablesorter-header",
                cssHeaderRow: "tablesorter-headerRow",
                cssIcon: "tablesorter-icon",
                cssChildRow: "tablesorter-childRow",
                cssInfoBlock: "tablesorter-infoOnly",
                cssProcessing: "tablesorter-processing",

                // *** SELECTORS ***
                // jQuery selectors used to find the header cells.
                selectorHeaders: '> thead th, > thead td',

                // jQuery selector of content within selectorHeaders
                // that is clickable to trigger a sort.
                selectorSort: "th, td",

                // rows with this class name will be removed automatically
                // before updating the table cache - used by "update",
                // "addRows" and "appendCache"
                selectorRemove: "tr.remove-me",

                // *** DEBUGING ***
                // send messages to console
                debug: false

            }).tablesorterPager({

                // target the pager markup - see the HTML block below
                container: $(".pager"),

                // use this url format "http:/mydatabase.com?page={page}&size={size}" 
                ajaxUrl: null,

                // process ajax so that the data object is returned along with the
                // total number of rows; example:
                // {
                //   "data" : [{ "ID": 1, "Name": "Foo", "Last": "Bar" }],
                //   "total_rows" : 100 
                // } 
                ajaxProcessing: function (ajax) {
                    if (ajax && ajax.hasOwnProperty('data')) {
                        // return [ "data", "total_rows" ]; 
                        return [ajax.data, ajax.total_rows];
                    }
                },

                // output string - default is '{page}/{totalPages}';
                // possible variables:
                // {page}, {totalPages}, {startRow}, {endRow} and {totalRows}
                output: '{startRow} to {endRow} ({totalRows})',

                // apply disabled classname to the pager arrows when the rows at
                // either extreme is visible - default is true
                updateArrows: true,

                // starting page of the pager (zero based index)
                page: 0,

                // Number of visible rows - default is 10
                size: 25,

                // if true, the table will remain the same height no matter how many
                // records are displayed. The space is made up by an empty 
                // table row set to a height to compensate; default is false 
                fixedHeight: false,

                // remove rows from the table to speed up the sort of large tables.
                // setting this to false, only hides the non-visible rows; needed
                // if you plan to add/remove rows with the pager enabled.
                removeRows: true,

                // css class names of pager arrows
                // next page arrow
                cssNext: '.next',
                // previous page arrow
                cssPrev: '.prev',
                // go to first page arrow
                cssFirst: '.first',
                // go to last page arrow
                cssLast: '.last',
                // select dropdown to allow choosing a page
                cssGoto: '.gotoPage',
                // location of where the "output" is displayed
                cssPageDisplay: '.pagedisplay',
                // dropdown that sets the "size" option
                cssPageSize: '.pagesize',
                // class added to arrows when at the extremes 
                // (i.e. prev/first arrows are "disabled" when on the first page)
                // Note there is no period "." in front of this class name
                cssDisabled: 'disabled'

            });


        }






        function Next(obj, obj1) {
            var index;


            var ddlNumbers = document.getElementById(obj1);
            var options = ddlNumbers.getElementsByTagName("option")
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected) {
                    index = i;
                }
            }
            index = index + 1;
            if (index >= ddlNumbers.length) {

            }
            else {
                ddlNumbers.value = ddlNumbers[index].value;
                document.getElementById(obj1).onchange();
            }
            return false;
        }

        //http://www.aspforums.net/Threads/143568/Navigate-through-DropDownList-Items-using-Next-Previous-buttons-using-JavaScript-and-jQuery/

        function Previous(obj, obj1) {
            var index;
            var ddlNumbers = document.getElementById(obj1);



            var options = ddlNumbers.getElementsByTagName("option")
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected) {
                    index = i;
                }
            }
            index = index - 1;
            if (index <= -1) {
            }
            else {
                ddlNumbers.value = ddlNumbers[index].value;
                document.getElementById(obj1).onchange();
            }
            return false;
        }



    </script>

    <style>
        .highRating {
            color: #009900 !important;
        }

        .mediumRating {
        }

        .lowRating {
            color: #7b7b7c !important;
        }
    </style>
</asp:Content>
