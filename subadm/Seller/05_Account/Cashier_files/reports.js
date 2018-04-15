var TeG = TeG || {};

TeG.Reports = function () {

    function printGrid(gridElem) {
        var gridElement = (gridElem instanceof Array) ? gridElem : [gridElem],
            printableContent = '',
            win = window.open('', '', 'width=800, height=500'),
            doc = win.document.open();

        var htmlStart =
                '<!DOCTYPE html>' +
                '<html>' +
                '<head>' +
                '<meta charset="utf-8" />' +
                '<title>Kendo UI Grid</title>' +
                '<style>' +
                'html { font: 11pt sans-serif; }' +
                '.k-grid { border-top-width: 0; }' +
                '.k-grid, .k-grid-content { height: auto !important; }' +
                '.k-grid-content { overflow: visible !important; }' +
                'div.k-grid table { table-layout: auto; width: 100% !important; }' +
                '.k-grid .k-grid-header th { border-top: 1px solid; }' +
                '.k-grid-toolbar, .k-grid-pager > .k-link { display: none; }' +
                '.reportSummaryData { overflow: auto; padding-left: 4px;} '+
                '.reportSummaryData > div { float: left; }    '+
                '.reportSummaryData dl > dt { background-color: #ebebeb; font-size: 12px;  margin: 0 2px 0 0; padding: 3px 5px; text-align: center; }'+
                '.reportSummaryData dl > dd { background-color: #feeed2; font-weight: bold;  margin: 0 2px 3px 0; padding: 3px 5px; }'+
                '.reportSummaryData > .reportSummaryData { padding-left: 0; }' +
                '.k-grid-pager { display: none; }' +
                '</style>' +
                '</head>' +
                '<body>';

        var htmlEnd =
                '</body>' +
                '</html>';

        for (i = 0; i < gridElement.length; i++) {
            var gridHeader = gridElement[i].children('.k-grid-header');
            if (gridHeader[0]) {
                var thead = gridElement[i].find('thead:first').clone().addClass('k-grid-header');
                printableContent += gridElement[i]
                    .clone()
                        .children('.k-grid-header').remove()
                    .end()
                        .children('.k-grid-content')
                            .find('table')
                                .first()
                                    .children('tbody').before(thead)
                                .end()
                            .end()
                        .end()
                    .end()[0].outerHTML;
            } else {
                printableContent += gridElement[i].clone()[0].outerHTML;
            }
        }

        doc.write(htmlStart + printableContent + htmlEnd);
        doc.close();
        win.print();
    }

    function leadingZero(number, length) {
        var str = '' + number;
        while (str.length < length) {
            str = '0' + str;
        }
        return str;
    }

    function restoreColumnsWidthes(event) {
        var gridId = $(event.sender.wrapper).attr('id');
        var grid = $(String.format('#{0}', gridId));
        var gridHeader = grid.find('div.k-grid-header>div.k-grid-header-wrap>table[role="grid"]>thead[role="rowgroup"]>tr[role="row"]');
        var gridContentRows = grid.find('div.k-grid-content table tr');

        if (!window.sessionStorage) {
            return;
        }

        var gridColumnsState = JSON.parse(sessionStorage.getItem('gridColumnsState') || '{}');
        var columnsWidthes = gridColumnsState[gridId] || {};

        if ($.isEmptyObject(columnsWidthes)) {
            return;
        }

        for (column in columnsWidthes) {
            var header = gridHeader.find(String.format('[data-field="{0}"]', column));
            var columnWidth = columnsWidthes[column];
            // Setting width to column header
            //$(header).width(columnWidth);

            var headerIndex = $(header).index();
            $('div.k-grid-header table col').eq(headerIndex).width(columnWidth);
            $('div.k-grid-content table col').eq(headerIndex).width(columnWidth);
            /*
            $(gridContentRows).each(function () {
                var row = $(this);
                var tdElements = row.children('td');
                // Setting width to "td" elements
                $(tdElements).eq(headerIndex).width(columnWidth);
            });
            */
        }

        $('div.k-grid-header table col').last().removeAttr('style');
        $('div.k-grid-content table col').last().removeAttr('style');
    }

    function restoreGridOptions() {

        setTimeout(function () {
            var gridId = $('div#report div#reportData div#reportGridData div[data-role="grid"]').attr('id');
            var grid = $('div#report div#reportData div#reportGridData div[data-role="grid"]').data('kendoGrid');
            var storedOptions = sessionStorage.getItem(gridId + '_grid_options');
            var gridOptions = grid.getOptions();

            if (!gridId || !grid || !gridOptions) return;

            storedOptions = JSON.parse(storedOptions);

            if (storedOptions) {
                gridOptions.columns = storedOptions.columns;
            }

            grid.setOptions(gridOptions);
            grid.dataSource.read();
        });
    }

    return {
        //#region Config
        Config: {
            //#region LiveGamesFraudCheck
            LiveGamesFraudCheck: {
                dataSourceSchemaInit: {
                    model: {
                        fields: {
                            Date: { type: "date" },
                            AccountName: { type: "string" },
                            MasterAgent: { type: "string" },
                            Agent: { type: "string" },
                            TableCode: { type: "string" },
                            RoundId: { type: "number" },
                            Currency: { type: "string" },
                            BetType: { type: "string" },
                            Bet: { type: "number" },
                            Payout: { type: "number" }
                        }
                    }
                },

                columnsArr: [
                        {
                            field: "Date",
                            type: "date",
                            title: TeG.Translations.ColumnNameDateTime,
                            format: "{0:yyyy-MM-dd HH:mm:ss} GMT 0",
                            width: TeG.BaseKendoGridColumnsConfig.BetTime,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        }, {
                            field: "AccountName",
                            type: "string",
                            title: TeG.Translations.ColumnNameAccountName,
                            width: TeG.BaseKendoGridColumnsConfig.AccountNumber,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "MasterAgent",
                            type: "string",
                            title: TeG.Translations.ColumnNameMasterAgent,
                            width: TeG.BaseKendoGridColumnsConfig.MasterAgent,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }                            
                        },
                        {
                            field: "Agent",
                            type: "string",
                            title: TeG.Translations.ColumnNameAgent,
                            width: TeG.BaseKendoGridColumnsConfig.Agent,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "TableCode",
                            type: "string",
                            title: TeG.Translations.ColumnNameTableCode,
                            width: TeG.BaseKendoGridColumnsConfig.TableCode,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "RoundId",
                            type: "number",
                            title: TeG.Translations.ColumnNameRoundId,
                            width: TeG.BaseKendoGridColumnsConfig.RoundId,
                            filterable: true,
                            attributes: { class: "gridDataNumber" }
                        },
                        {
                            field: "Currency",
                            type: "string",
                            title: TeG.Translations.ColumnNameCurrency,
                            width: TeG.BaseKendoGridColumnsConfig.Currency,
                            filterable: true
                        },
                        {
                            field: "BetType",
                            type: "string",
                            title: TeG.Translations.ColumnNameBetType,
                            width: TeG.BaseKendoGridColumnsConfig.BetType,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "Bet",
                            type: "number",
                            title: TeG.Translations.ColumnNameBetAmountCredits,
                            filterable: true,
                            width: TeG.BaseKendoGridColumnsConfig.BetAmount,
                            attributes: { class: "gridDataNumber" }
                        },
                        {
                            field: "Payout",
                            type: "number",
                            title: TeG.Translations.ColumnNamePayoutCredits,
                            filterable: true,
                            width: TeG.BaseKendoGridColumnsConfig.GainAmount,
                            attributes: { class: "gridDataNumber" }
                        }//,
                        //{
                        //    attributes: { class: "fake-column" }
                        //}
                ],
                columnsArr: [
                        {
                            field: "Date",
                            type: "date",
                            title: TeG.Translations.ColumnNameDateTime,
                            format: "{0:yyyy-MM-dd HH:mm:ss} GMT 0",
                            width: TeG.BaseKendoGridColumnsConfig.BetTime,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        }, {
                            field: "AccountName",
                            type: "string",
                            title: TeG.Translations.ColumnNameAccountName,
                            width: TeG.BaseKendoGridColumnsConfig.AccountNumber,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "MasterAgent",
                            type: "string",
                            title: TeG.Translations.ColumnNameMasterAgent,
                            width: TeG.BaseKendoGridColumnsConfig.MasterAgent,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }                            
                        },
                        {
                            field: "Agent",
                            type: "string",
                            title: TeG.Translations.ColumnNameAgent,
                            width: TeG.BaseKendoGridColumnsConfig.Agent,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "TableCode",
                            type: "string",
                            title: TeG.Translations.ColumnNameTableCode,
                            width: TeG.BaseKendoGridColumnsConfig.TableCode,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "RoundId",
                            type: "number",
                            title: TeG.Translations.ColumnNameRoundId,
                            width: TeG.BaseKendoGridColumnsConfig.RoundId,
                            filterable: true,
                            attributes: { class: "gridDataNumber" }
                        },
                        {
                            field: "Currency",
                            type: "string",
                            title: TeG.Translations.ColumnNameCurrency,
                            width: TeG.BaseKendoGridColumnsConfig.Currency,
                            filterable: true
                        },
                        {
                            field: "BetType",
                            type: "string",
                            title: TeG.Translations.ColumnNameBetType,
                            width: TeG.BaseKendoGridColumnsConfig.BetType,
                            filterable: true,
                            attributes: { class: "gridDataNotNumber" }
                        },
                        {
                            field: "Bet",
                            type: "number",
                            title: TeG.Translations.ColumnNameBetAmountCredits,
                            filterable: true,
                            width: TeG.BaseKendoGridColumnsConfig.BetAmount,
                            attributes: { class: "gridDataNumber" }
                        },
                        {
                            field: "Payout",
                            type: "number",
                            title: TeG.Translations.ColumnNamePayoutCredits,
                            filterable: true,
                            width: TeG.BaseKendoGridColumnsConfig.GainAmount,
                            attributes: { class: "gridDataNumber" }
                        }//,
                        //{
                        //    attributes: { class: "fake-column" }
                        //}
                ]
            },
            //#endregion LiveGamesFraudCheck

            //#region ProgressiveWinReconcilliatonDetails
            ProgressiveWinReconcilliatonDetails: {
                columnsArrSchema: {
                    model: {
                        fields: {
                            JackpotDate: { type: "date" },
                            MasterAgent: { type: "string" },
                            Agent: { type: "string" },
                            AccountNo: { type: "string" },
                            AccountType: { type: "string" },
                            Name: { type: "string" },
                            Game: { type: "string" },
                            JackpotAmount: { type: "number" },
                            JackpotCurrency: { type: "string" },
                            ProgressiveWinLogId: { type: "number"}
                        }
                    }
                },

                columnsArr: [
                    {
                        field: "JackpotDate",
                        format: "{0:yyyy-MM-dd HH:mm:ss}",
                        title: TeG.Translations.ColumnNameJackpotDate,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotDate,
                        filterable: false,
                    },
                    {
                        field: "MasterAgent",
                        title: TeG.Translations.ColumnNameMasterAgent,
                        width: TeG.BaseKendoGridColumnsConfig.MasterAgent,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" },
                        hidden: true
                    },
                    {
                        field: "Agent",
                        title: TeG.Translations.ColumnNameAgent,
                        width: TeG.BaseKendoGridColumnsConfig.Agent,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "AccountNo",
                        title: TeG.Translations.ColumnNameAccountNo,
                        width: TeG.BaseKendoGridColumnsConfig.AccountNumber,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "AccountType",
                        title: TeG.Translations.ColumnNameAccountType,
                        width: TeG.BaseKendoGridColumnsConfig.AccountType,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" },
                        template: function (dataItem) {
                            if (dataItem.AccountType == 'Player') {
                                return "<div style='text-align: center;'><img src='/Images/icPlayer.png' title='" + dataItem.AccountType + "' /></div>";
                            } else if (dataItem.AccountType == 'Station') {
                                return "<div style='text-align: center;'><img src='/Images/icStation.png' title='" + dataItem.AccountType + "' /></div>";
                            }
                        }
                    },
                    {
                        field: "Name",
                        title: TeG.Translations.ColumnNameName,
                        width: TeG.BaseKendoGridColumnsConfig.Name,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "Game",
                        title: TeG.Translations.ColumnNameGameName,
                        width: TeG.BaseKendoGridColumnsConfig.GameCategoryGameName,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "JackpotAmount",
                        format: "{0:n2}",
                        title: TeG.Translations.ColumnNameJackpotAmount,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotAmount,
                        filterable: true,
                        attributes: { class: "gridDataNumber" }
                    },
                    {
                        field: "JackpotCurrency",
                        title: TeG.Translations.ColumnNameJackpotCurrency,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotCurrency,
                        filterable: true
                    },                    
                    {
                        field: "ProgressiveWinLogId",
                        hidden: true
                    }/*,
                    {
                        attributes: { class: "fake-column" }
                    }*/
                ],

                drillDownColumnsArrSchema: {
                    model: {
                        fields: {
                            Date: { type: "date" },
                            Currency: { type: "string" },
                            DepositAmount: { type: "number" },
                            WithdrawalAmount: { type: "number" },                            
                            AgentNetCash: { type: "number" }
                        }
                    }
                },

                drillDownColumnsArr: [
                    {
                        field: "Date",
                        format: "{0:yyyy-MM-dd HH:mm:ss}",
                        title: TeG.Translations.ColumnNameDate,
                        width: TeG.BaseKendoGridColumnsConfig.TransferDate,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                   {
                       field: "Currency",
                       title: TeG.Translations.ColumnNameCurrency,
                       width: TeG.BaseKendoGridColumnsConfig.Currency,
                       filterable: true,
                   },
                   {
                       field: "DepositAmount",
                       format: "{0:n2}",
                       title: TeG.Translations.ColumnNameDepositAmount,
                       width: TeG.BaseKendoGridColumnsConfig.DepositAmount,
                       filterable: true,
                       attributes: { class: "gridDataNumber" }
                   },
                   {
                       field: "WithdrawalAmount",
                       format: "{0:n2}",
                       title: TeG.Translations.ColumnNameWithdrawalAmount,
                       width: TeG.BaseKendoGridColumnsConfig.WithdrawalAmount,
                       filterable: true,
                       attributes: { class: "gridDataNumber" }
                   },                   
                    {
                        field: "AgentNetCash",
                        format: "{0:n2}",
                        title: TeG.Translations.ColumnNameAgentNetCash,
                        width: TeG.BaseKendoGridColumnsConfig.AgentNetCash,
                        filterable: true,
                        attributes: { class: "gridDataNumber" }
                    }/*,
                    {
                        attributes: { class: "fake-column" }
                    }*/
                ]
            },
            //#endregion ProgressiveWinReconcilliatonDetails

            //#region ProgressiveWins
            ProgressiveWins: {
                columnsArrSchema: {
                    data: 'Data',
                    total: function (response) {
                        return response.Total;
                    },
                    errors: 'Errors',
                    parse: function (response) {
                            ProgressiveWinsSummary = response.Summary;
                            return response;
                    },
                    model: {
                        fields: {
                            JackpotDate: { type: "date" },
                            Currency: { type: "string" },
                            Major: { type: "number" },
                            Mega: { type: "number" },
                            Mini: { type: "number" },
                            Minor: { type: "number" },
                            JackpotAmount: { type: "number" }
                        }
                    }
                },

                columnsArrSummary: [                                
                                {
                                    field: "Currency",
                                    title: TeG.Translations.ColumnNameCurrency,
                                },
                                {
                                    field: "Mega",
                                    title: TeG.Translations.ColumnNameMega,
                                },
                                {
                                    field: "Major",
                                    title: TeG.Translations.ColumnNameMajor,
                                },
                                {
                                    field: "Minor",
                                    title: TeG.Translations.ColumnNameMinor,
                                },
                                {
                                    field: "Mini",
                                    title: TeG.Translations.ColumnNameMini,
                                },
                                {
                                    field: "JackpotAmount",
                                    title: TeG.Translations.ColumnNameJackpotAmount,
                                }
                ],
                columnsArr: [
                                {
                                    field: "JackpotDate",
                                    //format: "{0:yyyy-MM-dd HH:mm:ss}",
                                    type: "date",
                                    format: "{0:yyyy-MM-dd}",
                                    title: TeG.Translations.ColumnNameJackpotDate,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                                    filterable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "Currency",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameCurrency,
                                    width: TeG.BaseKendoGridColumnsConfig.Currency,
                                    filterable: false,
                                    sortable: false
                                },
                                {
                                    field: "Mega",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameMega,
                                    width: TeG.BaseKendoGridColumnsConfig.Mega,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "Major",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameMajor,
                                    width: TeG.BaseKendoGridColumnsConfig.Major,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "Minor",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameMinor,
                                    width: TeG.BaseKendoGridColumnsConfig.Minor,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "Mini",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameMini,
                                    width: TeG.BaseKendoGridColumnsConfig.Mini,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "JackpotAmount",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameJackpotAmount,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotAmount,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    attributes: { class: "fake-column" }
                                }
                ],

                drillDownColumnsArrSchema: {
                    data: 'Data',
                    total: function (response) {
                        return response.Total;
                    },
                    errors: 'Errors',
                    model: {
                        fields: {
                            JackpotDate: { type: "date" },
                            MasterAgent: { type: "string" },
                            Agent: { type: "string" },
                            AccountNo: { type: "string" },
                            AccountType: { type: "string" },
                            Name: { type: "string" },
                            Game: { type: "string" },
                            JackpotAmount: { type: "number" },
                            JackpotCurrency: { type: "string" },
                            JackpotType: { type: "string" },
                            SessionId: { type: "number" },
                            TransNumber: { type: "number" }
                        }
                    }
                },

                drillDownColumnsArr: [
                    {
                        field: "JackpotDate",
                        format: "{0:yyyy-MM-dd HH:mm:ss}",
                        //format: "{0:dd-MM-yyyy}",
                        title: TeG.Translations.ColumnNameJackpotDate,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                   {
                       field: "MasterAgent",
                       title: TeG.Translations.ColumnNameMasterAgent,
                       width: TeG.BaseKendoGridColumnsConfig.ProgressiveWinsMasterAgent,
                       filterable: true,
                       attributes: { class: "gridDataNotNumber" }
                   },
                   {
                       field: "Agent",
                       title: TeG.Translations.ColumnNameAgent,
                       width: TeG.BaseKendoGridColumnsConfig.ProgressiveWinsAgent,
                       filterable: true,
                       attributes: { class: "gridDataNotNumber" }
                   },
                   {
                       field: "AccountNo",
                       title: TeG.Translations.ColumnNameAccountName,
                       width: TeG.BaseKendoGridColumnsConfig.AccountNo,
                       filterable: true,
                       attributes: { class: "gridDataNotNumber" }
                   },                   
                   {
                       field: "AccountType",
                       title: TeG.Translations.ColumnNameAccountType,
                       width: TeG.BaseKendoGridColumnsConfig.AccountType,
                       filterable: true,
                       attributes: { class: "gridDataNotNumber" },
                       template: function (dataItem) {
                           if (dataItem.AccountType == 'Player') {
                               return "<div style='text-align: center;'><img src='/Images/icPlayer.png' title='" + dataItem.AccountType + "' /></div>";
                           } else if (dataItem.AccountType == 'Station') {
                               return "<div style='text-align: center;'><img src='/Images/icStation.png' title='" + dataItem.AccountType + "' /></div>";
                           }
                       }
                   },
                   {
                       field: "Name",
                       title: TeG.Translations.ColumnNameName,
                       width: TeG.BaseKendoGridColumnsConfig.ProgressiveWinsName,
                       filterable: true,
                       attributes: { class: "gridDataNotNumber" }
                   },
                    {
                        field: "JackpotCurrency",
                        title: TeG.Translations.ColumnNameJackpotCurrency,
                        width: TeG.BaseKendoGridColumnsConfig.Currency,
                        filterable: false,
                        sortable: false
                    },
                    {
                        field: "Game",
                        title: TeG.Translations.ColumnNameGame,
                        width: TeG.BaseKendoGridColumnsConfig.GameCategoryGameName,
                        filterable: true,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "JackpotAmount",
                        title: TeG.Translations.ColumnNameJackpotAmount,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotAmount,
                        filterable: true,
                        attributes: { class: "gridDataNumber" },
                        format: "{0:n2}"
                    },
                    {
                        field: "JackpotType",
                        title: TeG.Translations.ColumnNameJackpotType,
                        width: TeG.BaseKendoGridColumnsConfig.JackpotType,
                        filterable: false,
                        sortable: false,
                        attributes: { class: "gridDataNotNumber" }
                    },
                    {
                        field: "SessionId",
                        title: TeG.Translations.ColumnNameSessionId,
                        width: TeG.BaseKendoGridColumnsConfig.SessionId,
                        filterable: true,
                        sortable: true,
                        hidden: true,
                        attributes: { class: "gridDataNumber" }
                    },
                    {
                        field: "TransNumber",
                        title: TeG.Translations.ColumnNameTransactionId,
                        width: TeG.BaseKendoGridColumnsConfig.TransactionId,
                        filterable: true,
                        sortable: true,
                        hidden: true,
                        attributes: { class: "gridDataNumber" }
                    },
                    {
                        attributes: { class: "fake-column" },
                        headerAttributes: { class: "fake-column" }
                    }
                ]
            },
            //#endregion ProgressiveWins

            //#region TournamentWins
            TournamentWins: {
                columnsArrSchema: {
                    data: 'Data',
                    total: function (response) {
                        return response.Total;
                    },
                    errors: 'Errors',
                    parse: function (response) {
                        TournamentWinsSummary = response.Summary;
                        return response;
                    },
                    model: {
                        fields: {
                            PeriodStartTimeUTC: { type: "date" },
                            PeriodEndTimeUTC: { type: "date" },
                            PayoutDateUTC: { type: "date" },
                            MasterAgent: { type: "string" },
                            Agent: { type: "string" },
                            AccountNumber: { type: "string" },
                            AliasName: { type: "string" },
                            FirstName: { type: "string" },
                            LastName: { type: "string" },
                            TournamentId: { type: "number" },
                            SponsorshipType: { type: "string" },
                            TournamentName: { type: "string" },
                            Currency: { type: "string" },
                            Rank: { type: "number" },
                            WinAmount: { type: "number" },
                            PayoutAmount: { type: "number" },
                            WinType: { type: "string" }
                        }
                    }
                },

                columnsArrSummary: [
                                {
                                    field: "Currency",
                                    title: TeG.Translations.ColumnNameCurrency,
                                },
                                {
                                    field: "SponsorshipType",
                                    title: TeG.Translations.ColumnNameSponsorshipType,
                                },
                                {
                                    field: "WinAmount",
                                    title: TeG.Translations.ColumnNameWinAmount,
                                },
                                {
                                    field: "PayoutAmount",
                                    title: TeG.Translations.ColumnNameCreditedAmount
                                }
                ],
                columnsArr: [
                                {
                                    field: "PeriodStartTimeUTC",
                                    format: "{0:yyyy-MM-dd HH:mm:ss}",
                                    type: "date",
                                    title: TeG.Translations.ColumnNameWinPeriodStart,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                                    filterable: true,
                                    sortable: true,
                                    //template: function (dataItem) {
                                    //    return kendo.toString(dataItem.PeriodStartTimeUTC, "yyyy-MM-dd HH:mm:ss") + " - " + kendo.toString(dataItem.PeriodEndTimeUTC, "yyyy-MM-dd HH:mm:ss");
                                    //},
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "PeriodEndTimeUTC",
                                    format: "{0:yyyy-MM-dd HH:mm:ss}",
                                    type: "date",
                                    title: TeG.Translations.ColumnNameWinPeriodEnd,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                    //hidden: true,
                                    //menu: false
                                },
                                {
                                    field: "PayoutDateUTC",
                                    format: "{0:yyyy-MM-dd HH:mm:ss}",
                                    type: "date",
                                    title: TeG.Translations.ColumnNameCreditDate,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "MasterAgent",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameMasterAgent,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentMasterAgentName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "Agent",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameAgent,
                                    width: TeG.BaseKendoGridColumnsConfig.AgentName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "AccountNumber",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameAccountNumber,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentAccountName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "AliasName",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameAliasName,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentAliasName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "FirstName",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameFirstName,
                                    width: TeG.BaseKendoGridColumnsConfig.FirstName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "LastName",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameLastName,
                                    width: TeG.BaseKendoGridColumnsConfig.LastName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "SponsorshipType",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameSponsorshipType,
                                    width: TeG.BaseKendoGridColumnsConfig.SponsorshipType,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "TournamentId",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTournamentId,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentId,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" }
                                },
                                {
                                    field: "TournamentName",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameTournamentName,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentName,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "Currency",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameCurrency,
                                    width: TeG.BaseKendoGridColumnsConfig.CurrencyIsoCode,
                                    filterable: true,
                                    sortable: true
                                },
                                {
                                    field: "Rank",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameRank,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentId,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" }
                                },
                                {
                                    field: "WinAmount",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameWinAmount,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentWinAmount,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "WinType",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameWinType,
                                    width: TeG.BaseKendoGridColumnsConfig.CurrencyIsoCode,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    attributes: { class: "fake-column" }
                                }
                ]
            },
            //#endregion TournamentWins

            //#region Billing
            Billing: {
                columnsArr: [
                    
                                {
                                    field: "TimePeriod",
                                    type: "date",
                                    format:"{0:yyyy-MM-dd HH:mm:ss}",
                                    title: TeG.Translations.ReportsRequestLabelTimePeriod,
                                    width: TeG.BaseKendoGridColumnsConfig.JackpotDateShort,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" },
                                    hidden: true,
                                    menu: false
                                },
                                
                                {
                                    field: "LoginName",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameMasterAgent,
                                    width: TeG.BaseKendoGridColumnsConfig.MasterAgent,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "Currency",
                                    type: "string",
                                    title: TeG.Translations.ColumnNameCurrency,
                                    width: TeG.BaseKendoGridColumnsConfig.Currency,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNotNumber" }
                                },
                                {
                                    field: "SumFlashRNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameFlashRng,
                                    width: TeG.BaseKendoGridColumnsConfig.FlashRng,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumFlashLG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameFlashLiveGames,
                                    width: TeG.BaseKendoGridColumnsConfig.Major,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumDownloadRNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameDownloadRNG,
                                    width: TeG.BaseKendoGridColumnsConfig.DownloadRNG,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumDownloadLG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameDownloadLiveGames,
                                    width: TeG.BaseKendoGridColumnsConfig.DownloadLiveGames,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumHTML5RNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameHtml5RNG,
                                    width: TeG.BaseKendoGridColumnsConfig.Html5RNG,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumHTML5LG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameHtml5LiveGames,
                                    width: TeG.BaseKendoGridColumnsConfig.Html5LiveGames,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumAndroidRNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameAndroidRNG,
                                    width: TeG.BaseKendoGridColumnsConfig.AndroidRNG,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumAndroidLG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameAndroidLiveGames,
                                    width: TeG.BaseKendoGridColumnsConfig.AndroidLiveGames ,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumiOSRNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameIosRNG,
                                    width: TeG.BaseKendoGridColumnsConfig.IosRNG,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumiOSLG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameiOSLiveGames,
                                    width: TeG.BaseKendoGridColumnsConfig.iOSLiveGames,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumRNG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTotalRNGNetWin,
                                    width: TeG.BaseKendoGridColumnsConfig.TotalRNGNetWin,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "MobileNetWin",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTotalMobileNetWin,
                                    width: TeG.BaseKendoGridColumnsConfig.TotalMobileNetWin,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumLG",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTotalLGNetWin,
                                    width: TeG.BaseKendoGridColumnsConfig.TotalLGNetWin,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },

                                {
                                    field: "TotalNetWin",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTotalNetWin,
                                    width: TeG.BaseKendoGridColumnsConfig.TotalNetWin,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"                   
                                },
                                {
                                    field: "SumPCA",
                                    type: "number",
                                    title: TeG.Translations.ColumnNamePca,
                                    width: TeG.BaseKendoGridColumnsConfig.PCA,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumProgressiveWin",
                                    type: "number",
                                    title: TeG.Translations.MenuProgressiveWinsReport,
                                    width: TeG.BaseKendoGridColumnsConfig.ProgressiveWin,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },
                                {
                                    field: "SumRefund",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameRefund,
                                    width: TeG.BaseKendoGridColumnsConfig.Refund,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}",
                                    hidden: true,
                                    menu: false
                                },
                                {
                                    field: "SumTournamentWin",
                                    type: "number",
                                    title: TeG.Translations.ColumnNameTournamentWins,
                                    width: TeG.BaseKendoGridColumnsConfig.TournamentWins,
                                    filterable: true,
                                    sortable: true,
                                    attributes: { class: "gridDataNumber" },
                                    format: "{0:n2}"
                                },

                                {
                                    attributes: { class: "fake-column" }
                                }
                ],

                DataSourceSchema: {
                    data: 'GridData.Data',
                    total: function (response) {
                        return response.GridData.Total;
                    },
                    parse: function (response) {
                        if (response.GridData.Total > 0) {
                            reportViewModel.summaryDataInit(response.SummaryData[0]);
                        }
                        return response;
                    },
                }
            }
            //#endregion Billing
        },
        //#endregion Config

        //#region Types
        Type: {
            AGENT: 1,
            MASTER_AGENT: 2,
            HEAD_OFFICE: 3
        },
        //#endregion Types

        //#region Common Helpers
        Show: function () {
            $("#body-pane-loader").hide();
            $("#body-pane-content").show();
            this.DisableToolBar();
            $('#searchReport').on('click', function () {
                window.isSearchClicked = true;
                $('#GlobalSearchEdit').val('');
            });
            $("#expandSearchCriteria").on('click', function () { TeG.Reports().Common().ExpandCollapse(); });
            $('#collapseBehaivor').on('click', function () { TeG.Reports().Common().ExpandCollapse(); });
            $('#expandBehaivor').on('click', function () { TeG.Reports().Common().ExpandCollapse(); });

            //            $("#fromDate").mask("99-99-9999",{placeholder:" "});
            //            $("#toDate").mask("99-99-9999",{placeholder:" "});
        },

        GetReportData: function (dataToSend, path, reportDataElem, successHandler) {
            $.ajax({
                url: path,
                type: "POST",
                data: dataToSend,
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                var grid = null;
                var gridId = $(data).find('.k-grid').attr('id');
                reportDataElem.html(data);

                if (gridId) {
                    grid = $('div#' + gridId).data('kendoGrid');
                } else {
                    grid = $('div[data-role="grid"]').data('kendoGrid');
                }

                TeG.Grid.Options.Restore(grid);

                grid.dataSource.read().then(function () {
                    successHandler && successHandler();
                });
            });

        },

        // deprecated
        GetReportSummaryData: function (path, reportDataElem) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {

                reportDataElem = (reportDataElem) ? reportDataElem : $('#reportSummaryData');
                if (data.Data.length == 0) {
                    reportDataElem.append('<div></div>');
                    return;
                }
                var dataReport = data.Data[0];
                var metaDataReport = data.MetaData;

                for (key in metaDataReport) {
                    if (metaDataReport[key].IsVisible) {
                        var value = dataReport[metaDataReport[key].Name];
                        var numberFormatting = "";

                        if (metaDataReport[key].FormatToDecimal) {
                            numberFormatting = "style='text-align: right;'";
                        }

                        if (value == '') {
                            value = '0';
                        }

                        reportDataElem.append('<div><dl><dt>' + metaDataReport[key].Caption + '</dt><dd style="height: 19px;" ' + numberFormatting + '>' + value + '</dd></dl></div>');
                    }
                }
            });
        },

        GetReportSummaryData2: function (path, reportDataElem, success) {
            $.ajax({
                url: path,
                type: "POST",
                success: (typeof (success) == 'function') ? success : null,
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    if (typeof (searchReportFlow) != 'undefined') {
                        searchReportFlow.isSummaryReceive = true;
                        searchReportFlow.isSummaryEmpty = true;
                    }
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                if (!data.IsSucceed) {
                    this.error(TeG.Utils().makeErrorObj(data)); return;
                }
                if (typeof (searchReportFlow) != 'undefined') {
                    searchReportFlow.isSummaryReceive = true;
                    if (data.Data && data.Data.length == 0) {
                        searchReportFlow.isSummaryEmpty = true;
                        TeG.Reports().Common().ShowReport();
                        return;
                    } else {
                        searchReportFlow.isSummaryEmpty = false;
                    }
                } else if (data.Data && data.Data.length == 0) {
                    TeG.Reports().Common().ShowReport();
                    return;
                }
                reportDataElem = (reportDataElem) ? reportDataElem : $('#reportSummaryData');
                if (!data.Data || data.Data.length == 0) {
                    reportDataElem.append('<div></div>');
                    return;
                }
                var dataReport = data.Data[0];
                var metaDataReport = data.MetaData;

                reportDataElem.html('');
                for (key in metaDataReport) {
                    if (metaDataReport[key].IsVisible) {
                        var value = dataReport[metaDataReport[key].Name];
                        var numberFormatting = "";

                        if (metaDataReport[key].FormatToDecimal) {
                            numberFormatting = "style='text-align: right;'";
                        }

                        if (value == '') {
                            value = '0';
                        }
                        reportDataElem.append('<div><dl><dt>' + metaDataReport[key].Caption + '</dt><dd style="height: 19px;" ' + numberFormatting + '>' + value + '</dd></dl></div>');
                    }
                }
                if ($('#last-updated').index() != -1 && data.LastUpdated) {
                    $('#last-updated').html(data.LastUpdated);
                }
                TeG.Reports().Common().ShowReport();
                if (typeof (this.success) == 'function') {
                    this.success(data);
                }
            });
        },

        GetReportSummaryDataKO: function (path, success) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    reportViewModel.summaryData$visible(false);
                    reportViewModel.loading$class(false);
                    reportViewModel.getSearchParameter().isError = true;
                    tegErrorHandler.processError(jqXHR);
                    TeG.Reports().DisableToolBar();
                }
            }).done(function (data) {
                if (!data.IsSucceed) {
                    this.error(TeG.Utils().makeErrorObj(data)); return;
                }
                if (data.Data && data.Data.length == 0) {
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    reportViewModel.summaryData$visible(false);
                    reportViewModel.gridShow();
                    return;
                }

                reportViewModel.summary.removeAll();
                for (var i = 0; i < data.MetaData.length; i++) {
                    if (typeof (data.Data[0][data.MetaData[i].Name]) != 'undefined') {
                        reportViewModel.summary.push({ caption: data.MetaData[i].Caption, value: data.Data[0][data.MetaData[i].Name] });
                    }
                }
                reportViewModel.summaryData$visible(true);
                reportViewModel.getSearchParameter().isSummaryReceived = true;
                reportViewModel.gridShow();
                if (typeof (success) == 'function') {
                    success(data);
                }
                splitterResize();
            });
        },

        GetReportCreditTransferSummaryData: function (path) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                if (typeof (searchReportFlow) != 'undefined') {
                    searchReportFlow.isSummaryReceive = true;
                    if (data.Data && data.Data.length == 0) {
                        searchReportFlow.isSummaryEmpty = true;
                        return;
                    } else {
                        searchReportFlow.isSummaryEmpty = false;
                    }
                } else {
                    if (data.Data && data.Data.length == 0) {
                        return;
                    }
                }
                var dataReport = data.Data[0];
                var metaDataReport = data.MetaData;

                for (key in metaDataReport) {
                    if (metaDataReport[key].IsVisible) {
                        if (metaDataReport[key].Name == "OpeningBalance") {
                            $('#openingBalance').text(dataReport[metaDataReport[key].Name]);
                        } else if (metaDataReport[key].Name == "ClosingBalance") {
                            $('#closingBalance').text(dataReport[metaDataReport[key].Name]);
                        } else if (metaDataReport[key].Name == "BalanceChange") {
                            $('#changeBalance').text(dataReport[metaDataReport[key].Name]);
                            if (-1 == dataReport[metaDataReport[key].Name].indexOf('-')) {
                                $('#changeBalance').parent().addClass('redUnderline');
                            } else {
                                $('#changeBalance').parent().addClass('greenUnderline');
                            }
                        }
                    }
                }
                $('#reportSummaryFromDate').text($('#fromDate').val() + ' 00:00');
                $('#reportSummaryToDate').text($('#toDate').val() + ' 23:59');
                if (/\-/.test($('#changeBalance').html())) {
                    $('#changeBalance').html($('#changeBalance').html().replace(/\-/, '<span>&#8722;</span> '))
                } else {
                    $('#changeBalance').html($('#changeBalance').html());
                }
                TeG.Reports().Common().ShowReport();
            });
        },

        GetReportCreditTransferLocationSummaryData: function (path) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    reportViewModel.getSearchParameter().isError = true;
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                if (data.IsSucceed === false || data.Data && data.Data.length === 0) {
                    reportViewModel.summaryData$visible(false);
                    return;
                }
                reportViewModel.summaryData$visible(true);
                if (typeof (searchReportFlow) != 'undefined') {
                    searchReportFlow.isSummaryReceive = true;
                    if (!data || !data.Data || !data.Data[0] || !data.MetaData) {
                        searchReportFlow.isSummaryEmpty = true;
                        return;
                    } else {
                        searchReportFlow.isSummaryEmpty = false;
                    }
                } else {
                    if (data.Data && data.Data.length == 0) {
                        return;
                    }
                }
                var dataReport = data.Data[0];
                var metaDataReport = data.MetaData;

                for (key in metaDataReport) {
                    if (metaDataReport[key].IsVisible) {
                        if (metaDataReport[key].Name == "OpeningBalance") {
                            reportViewModel.openingBalanceValue(dataReport[metaDataReport[key].Name]);
                        } else if (metaDataReport[key].Name == "ClosingBalance") {
                            reportViewModel.closingBalanceValue(dataReport[metaDataReport[key].Name]);
                        } else if (metaDataReport[key].Name == "BalanceChange") {
                            reportViewModel.changeBalancePlus$visible(/\-/.test(dataReport[metaDataReport[key].Name]));
                            reportViewModel.changeBalanceValue(dataReport[metaDataReport[key].Name].replace(/\-|\+/, ''));
                        }
                    }
                }
                reportViewModel.getSearchParameter().isSummaryReceived = true;
                reportViewModel.gridShow();
            });
        },
        // deprecated
        GetReportSummaryDataMultiCurrency: function (path, reportDataElem) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                if (data.Data.length == 0) {
                    $('#reportSummaryData').append('<div></div>'); // empty data control
                    return;
                }
                $('#reportSummaryData').append('<span></span>');
                $('#reportSummaryDataMultiCurrency').show();
                $('#multi-currency-select').off();
                var currencies = new Object;
                var availableCurrencies = new Array;
                var selectCurrencyCaption = data.MetaData.shift().Caption;
                for (var key in data.Data) {
                    var currencyData = new Array;
                    for (var meta in data.MetaData) {
                        currencyData.push({ dataCurrencyCaption: data.MetaData[meta].Caption, dataCurrencyValue: data.Data[key][data.MetaData[meta].Name] });
                    }
                    availableCurrencies.push({ currencyIso: data.Data[key].Currency, currencyId: data.Data[key].CurrencyId, currencyData: currencyData });
                    currencies[data.Data[key].CurrencyId] = { currentCurrencyValue: data.Data[key].CurrencyId, currencyData: currencyData }
                }
                if (typeof (multiCurrencyViewModel) == 'undefined') {
                    multiCurrencyViewModel = { currencyData: ko.observableArray(), availableCurrencies: ko.observable() };
                }
                multiCurrencyViewModel.selectCurrencyCaption = selectCurrencyCaption;
                multiCurrencyViewModel.availableCurrencies(availableCurrencies);
                multiCurrencyViewModel.currentCurrencyValue = currencies[$('#loginCurrencyId').val()].currentCurrencyValue;
                multiCurrencyViewModel.currencyData.removeAll();
                $(currencies[$('#loginCurrencyId').val()].currencyData).each(function () {
                    multiCurrencyViewModel.currencyData.push(this)
                });
                multiCurrencyViewModel.source = currencies;
                if (!ko.dataFor($('#reportSummaryDataMultiCurrency').get(0))) {
                    ko.applyBindings(multiCurrencyViewModel, $('#reportSummaryDataMultiCurrency').get(0));
                }
                $('#multi-currency-select').on('change', { multiCurrencyViewModel: multiCurrencyViewModel }, function (event) {
                    event.data.multiCurrencyViewModel.currencyData.removeAll();
                    for (index in event.data.multiCurrencyViewModel.source[$(this).val()].currencyData) {
                        event.data.multiCurrencyViewModel.currencyData.push(event.data.multiCurrencyViewModel.source[$(this).val()].currencyData[index]);
                    }
                    splitterResize();
                });
                $('#multi-currency-select').val(currencies[$('#loginCurrencyId').val()].currentCurrencyValue);
            });
        },

        GetReportSummaryDataMultiCurrency2: function (path, reportDataElem) {
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    if (typeof (searchReportFlow) != 'undefined') {
                        searchReportFlow.isSummaryReceive = true;
                        searchReportFlow.isSummaryEmpty = true;
                    }
                    TeG.Reports().Common().ShowReport();
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                if (typeof (searchReportFlow) != 'undefined') {
                    searchReportFlow.isSummaryReceive = true;
                    if (data.Data && data.Data.length == 0) {
                        searchReportFlow.isSummaryEmpty = true;
                        return;
                    } else {
                        searchReportFlow.isSummaryEmpty = false;
                    }
                } else {
                    if (data.Data && data.Data.length == 0) {
                        return;
                    }
                }
                $('#multi-currency-select').off();
                var currencies = new Object;
                var availableCurrencies = new Array;
                var selectCurrencyCaption = data.MetaData.shift().Caption;
                for (var key in data.Data) {
                    var currencyData = new Array;
                    for (var meta in data.MetaData) {
                        currencyData.push({ dataCurrencyCaption: data.MetaData[meta].Caption, dataCurrencyValue: data.Data[key][data.MetaData[meta].Name] });
                    }
                    availableCurrencies.push({ currencyIso: data.Data[key].Currency, currencyId: data.Data[key].CurrencyId, currencyData: currencyData });
                    currencies[data.Data[key].CurrencyId] = { currentCurrencyValue: data.Data[key].CurrencyId, currencyData: currencyData }
                }
                if (typeof (multiCurrencyViewModel) == 'undefined') {
                    multiCurrencyViewModel = { currencyData: ko.observableArray(), availableCurrencies: ko.observable() };
                }
                multiCurrencyViewModel.selectCurrencyCaption = selectCurrencyCaption;
                multiCurrencyViewModel.availableCurrencies(availableCurrencies);
                if (currencies[$('#loginCurrencyId').val()]) {
                    multiCurrencyViewModel.currentCurrencyValue = currencies[$('#loginCurrencyId').val()].currentCurrencyValue;
                } else {
                    for (key in currencies) {
                        multiCurrencyViewModel.currentCurrencyValue = currencies[key].currentCurrencyValue;
                    }
                }
                multiCurrencyViewModel.currencyData.removeAll();
                $(currencies[multiCurrencyViewModel.currentCurrencyValue].currencyData).each(function () {
                    multiCurrencyViewModel.currencyData.push(this)
                });
                multiCurrencyViewModel.source = currencies;
                if (!ko.dataFor($('#reportSummaryDataMultiCurrency').get(0))) {
                    ko.applyBindings(multiCurrencyViewModel, $('#reportSummaryDataMultiCurrency').get(0));
                }
                $('#multi-currency-select').on('change', { multiCurrencyViewModel: multiCurrencyViewModel }, function (event) {
                    event.data.multiCurrencyViewModel.currencyData.removeAll();
                    for (index in event.data.multiCurrencyViewModel.source[$(this).val()].currencyData) {
                        event.data.multiCurrencyViewModel.currencyData.push(event.data.multiCurrencyViewModel.source[$(this).val()].currencyData[index]);
                    }
                    splitterResize();
                });
                $('#multi-currency-select').val($('#loginCurrencyId').val());
                if ($('#last-updated').index() != -1 && data.LastUpdated) {
                    $('#last-updated').html(data.LastUpdated);
                }
                TeG.Reports().Common().ShowReport();
            });
        },

        DisableToolBar: function () {
            $('.globalSearchInput').attr('disabled', 'disabled');
            $.each($('#gridToolbar .item'), function () {
                $(this).removeClass('hover-enabled');
                $(this).find("#exportLink").removeClass("xl").addClass("xl-disabled");
                $(this).find("#linkPrint").removeClass("print").addClass("print-disabled");
                $(this).find("#linkRefresh").removeClass("refresh").addClass("refresh-disabled");
                var aClass = $(this).find('a').hide().attr('class');
                $(this).append('<a class="itemHover ' + aClass + '"  href="javascript: void(0)"></a>');
            });
        },

        EnableToolBar: function () {
            $('.globalSearchInput').removeAttr('disabled');
            $('.globalSearchInput').prop('disabled', false);
            $.each($('#gridToolbar .item'), function () {
                $(this).addClass('hover-enabled');
                $(this).find('.itemHover').remove();
                $(this).find('a').show();
                $(this).find("#exportLink").removeClass("xl-disabled").addClass("xl");
                $(this).find("#linkPrint").removeClass("print-disabled").addClass("print");
                $(this).find("#linkRefresh").removeClass("refresh-disabled").addClass("refresh");
            });
        },

        StoreTitle: function (type, titleData) {
            var titleData = titleData || {};

            if (type && type == TeG.Print.REPORT_SUMMARY_NOT_VISIBLE) {
                titleData.summaryTitle$visible = false;
            } else {
                titleData.summaryTitle$visible = true;
            }
            titleData.reportTitle = $.trim($('#gridToolBarContentName').html());
            if ($('input[name="timeGrouping"]').index() != -1) {
                titleData.timeGrouping = { visible: true, label: $('#showBy').html(), value: $('input[name="timeGrouping"]:checked').val() };
            } else {
                titleData.timeGrouping = { visible: false, label: '', value: '' }
            }
            if ($('input[name="customerType"]').index() != -1) {
                titleData.customerType = { visible: true, label: $('label[for="customerType"]').html(), value: $('input[name="customerType"]:checked').val() };
            } else {
                titleData.customerType = { visible: false, label: '', value: '' }
            }
            if (titleData.fromDate === undefined) {
                if ($('input[name="fromDate"]').index() != -1) {
                    if (typeof (reportViewModel) != 'undefined' && reportViewModel.date && reportViewModel.date.noTime) {
                        var fromDate = $('input[name="fromDate"]').val();
                    } else {
                        var fromDate = $('input[name="fromDate"]').val();
                        if ($('.time').index() != -1) {
                            if ($('.time').css('display') == 'inline-block') {
                                fromDate = TeG.Utils().formatDateTime($('input[name="fromDate"]').val(), $('select[name="fromDateHour"]').val(), $('select[name="fromDateMinute"]').val());
                            } else {
                                fromDate = TeG.Utils().formatDateTime($('input[name="fromDate"]').val(), '0', '0');
                            }
                        }
                    }
                    titleData.fromDate = { visible: true, label: $('label[for="fromDate"]').html(), value: fromDate };
                } else {
                    titleData.fromDate = { visible: false, label: '', value: '' }
                }
            } else {
                titleData.fromDate = { visible: true, label: $('label[for="fromDate"]').html(), value: titleData.fromDate };
            }
            if (titleData.toDate === undefined) {
                if ($('input[name="toDate"]').index() != -1) {
                    if (typeof (reportViewModel) != 'undefined' && reportViewModel.date && reportViewModel.date.noTime) {
                        var toDate = $('input[name="toDate"]').val();
                    } else {
                        var toDate = $('input[name="toDate"]').val();
                        if ($('.time').index() != -1) {
                            if ($('.time').css('display') == 'inline-block') {
                                toDate = TeG.Utils().formatDateTime($('input[name="toDate"]').val(), $('select[name="toDateHour"]').val(), $('select[name="toDateMinute"]').val());
                            } else {
                                toDate = TeG.Utils().formatDateTime($('input[name="toDate"]').val(), '23', '59');
                            }
                        }
                    }
                    titleData.toDate = { visible: true, label: $('label[for="toDate"]').html(), value: toDate };
                } else {
                    titleData.toDate = { visible: false, label: '', value: '' }
                }
            } else {
                titleData.toDate = { visible: true, label: $('label[for="toDate"]').html(), value: titleData.toDate };
            }
            if ($('select[name="groupingType"]').index() != -1) {
                titleData.groupingType = { visible: true, label: $('label[for="groupingType"]').html(), value: $('select[name="groupingType"] option:selected').html() };
            } else {
                titleData.groupingType = { visible: false, label: '', value: '' };
            }
            if ($('select[name="transactionType"]').index() != -1) {
                titleData.transactionType = { visible: true, label: $('label[for="transactionType"]').html(), value: $('select[name="transactionType"] option:selected').html() };
            } else {
                titleData.transactionType = { visible: false, label: '', value: '' }
            }
            if ($('select[name="timezoneType"]').index() != -1) {
                titleData.timezoneType = { visible: true, label: $('label[for="timezoneType"]').html(), value: $('select[name="timezoneType"] option:selected').html() };
            } else {
                titleData.timezoneType = { visible: false, label: '', value: '' }
            }
            if ($('#select-subordinates').index() != -1 && ($('#select-subordinates').is(':visible')) || $('#select-subordinates').css('display') == 'block') {
                titleData.selectSubordinates = {};
                titleData.selectSubordinates.visible = true;
                titleData.selectSubordinates.label = $('label[for="select-subordinates"]').html();
                titleData.selectSubordinates.value = [];
                $('#select-subordinates').find('div').each(function () {
                    if ($(this).hasClass('selected')) {
                        titleData.selectSubordinates.value.push({ name: $(this).find('input').val() });
                    }
                })
            } else {
                titleData.selectSubordinates = { visible: false, label: '', value: [{ name: '' }] }
                titleData.selectMA = { visible: false, label: '', value: [{ name: '' }] }
                titleData.selectA = { visible: false, label: '', value: [{ name: '' }] }
            }
            // select-ma and select-a for integrity report
            titleData.selectMA = { visible: false, label: '', value: [{ name: '' }] }
            titleData.selectA = { visible: false, label: '', value: [{ name: '' }] }

            if ($('select[name="gameClientType"]').index() != -1) {
                var gameClientTypeValue = '';
                if ($('#game-type-all').css('display') == 'inline') {
                    gameClientTypeValue = $('#game-type-all').html();
                } else {
                    gameClientTypeValue = $('select[name="gameClientType"] option:selected').html();
                }
                titleData.gameClientType = { visible: true, label: $('label[for="game-client-type"]').html(), value: gameClientTypeValue };
            } else {
                titleData.gameClientType = { visible: false, label: '', value: '' }
            }
            if ($('#currency-type').index() != -1) {
                if ($('#head-office-currency-choice').css('display') == 'inline') { // Gross Win Analysis Report
                    var value = $('#head-office-currency-choice').html().replace(/<.*?>/g, '');
                } else {
                    var value = $('#currency-type option:selected').html();
                }
                titleData.currencyType = { visible: true, label: $('label[for="currency-type"]').html(), value: value }
            } else {
                titleData.currencyType = { visible: false, label: '', value: '' }
            }
            // HACK below instruction used in GAR report @see model for GAR report method getRequestData
            titleData.timeGroupingPeriod = { visible: false, label: '', value: '' }
            titleData.masterAgentCurrency = { visible: false, label: '', value: '' }
            titleData.gameCategoryIdArray = { visible: false, label: '', value: '' }
            titleData.gameIdArray = { visible: false, label: '', value: '' }

            titleData = TeG.Reports().PlayCheck().StoreTitle(titleData);
            sessionStorage.setItem('printReportTitle', JSON.stringify(titleData));
        },

        StoreSummary: function (type) {
            var summary = {}
            summary.summaryData = [];
            if (type && type == TeG.Print.REPORT_SUMMARY_DATA_NOT_VISIBLE) {
                summary.reportSummaryData$visible = false
            } else {
                summary.reportSummaryData$visible = true
            }
            $('.reportSummaryData:visible dl').each(function () {
                var caption = $(this).find('dt').html();
                var value = null;
                if ($(this).find('dd > select').index() != -1) {
                    value = $(this).find('dd > select option:selected').html();
                } else {
                    var value = $(this).find('dd').html();
                }
                summary.summaryData.push({ caption: caption, value: value });
            });
            sessionStorage.setItem('printReportSummaryData', JSON.stringify(summary));
        },
        //#endregion

        //#region ProfitByGameType
        ProfitByGameType: function () {
            return {
                Show: function (type) {
                    $('#searchReport').on('click', function () {
                        TeG.Reports().Common().StartSearch();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", "59.997"),
                            customerType: ($('#reportHeaderContainer').find('input[name="customerType"]').index() != -1) ? $('#reportHeaderContainer').find('input[name="customerType"]:checked').val() : 'All',
                            groupingType: ($('#reportHeaderContainer').find('select[name="groupingType"]').index() != -1) ? $('#reportHeaderContainer').find('select[name="groupingType"]').val() : 'Gametype'
                        };
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array()
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            })
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                }
                            }
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        if (type && type == 'HO') {
                            var summaryMethod = TeG.Reports().GetReportSummaryDataMultiCurrency2;
                        } else {
                            var summaryMethod = TeG.Reports().GetReportSummaryData2;
                        }
                        $('#searchReport').addClass('loading');
                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.profitByGameType, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                summaryMethod(tegUrlHelper.profitByGameTypeSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode);
                            });
                    });
                },

                ShowOnTab: function () {
                    $('#searchReport').on('click', { that: this }, function () {
                        TeG.Reports().Common().StartSearch();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", "59.997"),
                            accountNumber: $('#customer-account-name').val()
                        };

                        TeG.Reports.requestData = data;
                        if (!TeG.Reports().Common().ValidateData()) return;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.playerProfitByGameType, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportSummaryData2(tegUrlHelper.playerProfitByGameTypeSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode);
                            });
                    });
                },

                DataBound: function (event) {
                    //restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBound(event);
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        if (!($('select[name="groupingType"]').val() == 'Daterange' && $('#select-subordinates').index() == -1)) {
                            gridPrint.setGrid($('#ReportProfitByGameTypeGrid1Grid').data('kendoGrid'));
                        }
                        gridPrint.setTitle('Profit by Game Type');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                },

                DataBoundOnTab: function (event) {
                    $('.call-pca-popup').removeClass('call-pca-popup');
                    TeG.Reports().ProfitByGameType().DataBound(event);
                    splitterResize();
                }
            };
        },
        //#endregion

        //#region ProgressiveWins
        ProgressiveWins: function () {

            return {
                Show: function() {
                    function innerGridsCounter() {
                        var counter = 0;

                        return function() {
                            return ++counter;
                        };
                    };

                    var innerGridOrder = innerGridsCounter();

                    $('#searchReport').unbind(kendo.support.click).bind(kendo.support.click, function () {

                        var fromDatepicker = $("#fromDate").data("kendoDatePicker");
                        var toDatepicker = $("#toDate").data("kendoDatePicker");

                        var fromDate = moment(fromDatepicker.value());
                        var toDate = moment(toDatepicker.value());

                        fromDate.hour(0).minute(0).second(0).millisecond(0);
                        toDate.hour(23).minute(59).second(59).millisecond(999);


                        var culturesMap = {
                            //'en': 'en-US',
                            'ch': 'zh-CN',
                            'tw': 'zh-TW',
                        }

                        var ProgressiveWinsSummary = [];
                        var memberDropDown = null;

                        var validator = new TeG.Validator();
                        validator.CleanError($('#fromDate'));
                        validator.CleanError($('#toDate'));
                        if (!TeG.Reports().Common().ValidateData()) return;

                        if (typeof ($("#master-agents").data('kendoDropDownList')) != 'undefined') {
                            memberDropDown = $("#master-agents").data('kendoDropDownList').value() || null;
                        } else if (typeof ($("#agents").data('kendoDropDownList')) != 'undefined') {
                            memberDropDown = $("#agents").data('kendoDropDownList').value() || null;
                        }


                        if ($('select[name="groupingType"]').val() == 'month') {
                            toDate.add(1, 'months').date(0);
                        }

                        var data = {
                            fromDate: fromDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                            toDate: toDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                            loginName: memberDropDown,
                            timeGroupingPeriod: $('select[name="groupingType"]').val(),
                            jackpotTypeid: ($('.jackpotTypeSelect').val() == '') ? null : parseInt($('.jackpotTypeSelect').val()),
                            currencyId: ($('#currency-type').val() == '' || typeof($('#currency-type').val()) == 'undefined') ? null : parseInt($('#currency-type').val())
                        };

                        /*if (parseInt($('#currency-type').val()) == TeG.Enums.MemberType.HeadOffice) {
                            data.currencyId = TeG.GlobalVariables.MemberCurrency.Id;
                        }*/
                        
                        window.isEmptyGrid = false;
                        window.isDataBound = false;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        //#region Print Report
                        /*Print Report*/
                        $('#linkPrint').click(function() {
                            printGrid([$('#reportSummary') ,$("#reportGridData")]);
                        });
                        /*End - Print Report*/
                        //#endregion Print Report

                        //#region Global Search
                        /*Global Search*/
                        $(".globalSearchInput ").on("focus", function(e) {
                            $(this).val('');
                        });
                        $(".globalSearchInput ").on("keyup", function(e) {
                            e.preventDefault();

                            $('#cancelSearch').show();
                            if ($.browser.safari && !TeG.isMobile() && !TeG.isIPad()) {
                                $('#cancelSearch').css('left', '170px');
                            }

                            $('#cancelSearch').unbind('click').bind('click', function(event) {

                                var grid = $('[data-role="grid"]').data('kendoGrid');
                                // Refresh filters
                                grid.dataSource.filter({});

                                $(".globalSearchInput ").val('');
                                $('#cancelSearch').hide();
                            });

                            if (e.which == kendo.keys.ENTER) {
                                var filter = { logic: "or", filters: [] };
                                $searchValue = $(this).val();
                                if ($searchValue) {
                                    filter.filters.push({ field: 'GlobalSearchCondition', operator: "contains", value: $searchValue });
                                }
                                //$("#reportGridData").data("kendoGrid").dataSource.query({ filter: filter });
                                $("#reportGridData").data("kendoGrid").dataSource.filter(filter);
                            }
                        });

                        /*End - Global Search*/
                        //#endregion Global Search

                        //#region Drill Down Report*/
                        function gridDetailInit(e) {
                            // @this = grid
                            var innerGridOrderValue = innerGridOrder();
                            if ($('select[name="groupingType"]').val() == 'day') {
                                fromDate = new Date(e.data.JackpotDate.getFullYear(), e.data.JackpotDate.getMonth(), e.data.JackpotDate.getDate(), 0, 0, 0, 0);
                                toDate = new Date(e.data.JackpotDate.getFullYear(), e.data.JackpotDate.getMonth(), e.data.JackpotDate.getDate(), 23, 59, 59, 997);
                                
                            }

                            var memberDropDown = null;
                            if (typeof ($("#master-agents").data('kendoDropDownList')) != 'undefined') {
                                memberDropDown = $("#master-agents").data('kendoDropDownList').value();
                            } else if (typeof ($("#agents").data('kendoDropDownList')) != 'undefined') {
                                memberDropDown = $("#agents").data('kendoDropDownList').value();
                            }

                            var drillDownFromDate = moment(e.data.JackpotDate);
                            var drillDownToDate = drillDownFromDate.clone();

                            drillDownFromDate.hour(0).minute(0).second(0).millisecond(0);
                            drillDownToDate.hour(23).minute(59).second(59).millisecond(999);

                            if ($('select[name="groupingType"]').val() == 'month') {
                                drillDownToDate.add(1, 'months').date(0);
                            }

                            var requestData = {
                                fromDate: drillDownFromDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                                toDate: drillDownToDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                                loginName: memberDropDown,
                                timeGroupingPeriod: $('select[name="groupingType"]').val(),
                                jackpotTypeid: ($('.jackpotTypeSelect').val() == '') ? null : parseInt($('.jackpotTypeSelect').val()),
                                currencyId: ($('#currency-type').val() == '' || typeof($('#currency-type').val()) == 'undefined') ? null : parseInt($('#currency-type').val())
                            }

                            var columns = TeG.Reports().Config.ProgressiveWins.drillDownColumnsArr;
                            $(columns).each(function (key, value) {
                                if (value.field == 'MasterAgent') {
                                    if (TeG.GlobalVariables.memberInfo != undefined && (TeG.GlobalVariables.memberInfo.memberTypeId == 3 || TeG.GlobalVariables.memberInfo.memberTypeId == 4)) {
                                        columns[key].hidden = true;
                                    } 
                                }
                                if (value.field == 'Agent') {
                                    if (TeG.GlobalVariables.memberInfo != undefined && TeG.GlobalVariables.memberInfo.memberTypeId == 4) {
                                        columns[key].hidden = true;
                                    } 
                                }
                            });
                        
                            tegPopups.showTotalHover();

                            $("<div/>").appendTo(e.detailCell).kendoGrid({
                                //dataSource: {
                                //    data: resultTransactionsByRound,
                                //    schema: TeG.Reports().Config.LiveGamesFraudCheck.dataSourceSchemaInit,
                                //    sort: { field: "PlaceBetTime", dir: "desc" }
                                //},
                                dataSource: {
                                    type: 'aspnetmvc-ajax',
                                    transport: {
                                        read: {
                                            // the remote service url
                                            url: tegUrlHelper.progressiveWinsDetailed,
                                            // the request type
                                            type: "post",
                                            // the data type of the returned result
                                            dataType: "json",
                                            // additional custom parameters sent to the remote service
                                            data: requestData,
                                        },
                                    },
                                    schema: TeG.Reports().Config.ProgressiveWins.drillDownColumnsArrSchema,
                                    pageSize: 25,
                                    serverPaging: true,
                                    serverFiltering: true,
                                    serverSorting: true,
                                },
                                pageable: {
                                    pageSize: 25,
                                    pageSizes: [25, 50, 100]
                                },
                                scrollable: true,
                                sortable: true,
                                filterable: true,
                                columnMenu: true,
                                columns: columns,
                                dataBound: function(event) {
                                    // @this = grid
                                    /*
                                    if (this.dataSource.data().length == 0) {
                                        // There is no data received
                                        $("<div/>").appendTo(e.detailCell).html('<div align="center"><h2>' + TeG.Translations.NoData + '</h2></div>');
                                        // Removing grid
                                        this.element.remove();
                                        this.destroy();
                                        tegPopups.closeTotalHover();
                                        return;
                                    }
                                    */
                                    var that = this;
                                    this.element.attr('id', 'reportGridDrillDownData-' + innerGridOrderValue);
                                    this.element.addClass('no-resize');
                                    //this.element.find('div.k-grid-header').addClass('no-resize');
                                    this.element.find('div.k-grid-content').addClass('no-resize');

                                    tegPopups.closeTotalHover();
                                    $(event.sender.thead).parent().parent().parent().css({ 'padding-right': 0 });
                                    event.sender.element.parent().parent().show();

                                    // Tooltips initialization
                                    if (!TeG.isMobile() && !this.tooltipInitialized) {
                                        //@this = grid
                                        this.thead.kendoTooltip({
                                            filter: "th:not(.fake-column)",
                                            content: function(e) {
                                                var target = e.target; // element for which the tooltip is shown
                                                that.tooltipInitialized = true;
                                                return $(target).text();
                                            }
                                        });
                                    }
                                },
                            });
                        }

//#endregion Drill Down Report*/

                        //#region Main Grid

                        function createGrid() {
                            var columns = TeG.Reports().Config.ProgressiveWins.columnsArr;

                            /*if (typeof ($("#master-agents").data('kendoDropDownList')) != 'undefined') {
                                memberDropDown = $("#master-agents").data('kendoDropDownList').value() || null;
                            } else if (typeof ($("#agents").data('kendoDropDownList')) != 'undefined') {
                                memberDropDown = $("#agents").data('kendoDropDownList').value() || null;
                            }*/
                            if ($('select[name="groupingType"]').val() == 'month') {
                                columns[0].format = "{0:yyyy-MM}";
                            }
                            $('#reportGridData').kendoGrid({
                                autoBind: false,
                                dataSource: new kendo.data.DataSource({
                                    type: 'aspnetmvc-ajax',
                                    transport: {
                                        read: {
                                            url: tegUrlHelper.progressiveWins,
                                            dataType: "json",
                                            method: "POST",
                                            data: data
                                        }
                                    },
                                    pageSize: 25,
                                    serverPaging: true,
                                    serverFiltering: true,
                                    serverSorting: true,
                                    schema: TeG.Reports().Config.ProgressiveWins.columnsArrSchema
                                }),
                                columns: columns,

                                pageable: {
                                    pageSize: 25,
                                    pageSizes: [25, 50, 100]
                                },
                                resizable: true,
                                sortable: {
                                    allowUnsort: false
                                },
                                columnResize: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnReorder: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnShow: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnHide: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                scrollable: true,
                                filterable: true,
                                columnMenu: true,
                                detailInit: $('select[name="groupingType"]').val() == "DateRange" ? null : gridDetailInit,
                                detailExpand: function(e) {
                                    e.masterRow.addClass('k-state-selected');
                                },
                                detailCollapse: function(e) {
                                    e.masterRow.removeClass('k-state-selected');
                                },
                                dataBound: function (e) {
                                    TeG.Reports().ProgressiveWins().DataBound(e);
                                }
                            }).addClass('main-grid-progressive-wins');


                            var grid = $('#reportGridData').data('kendoGrid');
                            TeG.Grid.Options.Restore(grid);
                            grid.dataSource.read();
                        }

                        //#endregion Main Grid

                        // Kendo translations
                        $.getScript(location.origin + "/Scripts/kendo/" + kendo.version + "/messages/kendo.messages." + (culturesMap[culture] || 'en-US') + ".min.js", function () {
                            createGrid();
                        });
                    });

                    var jackpotTypeSelect = $('select[name="jackpotType"]');
                    var jackpotTypeOptions = TeG.GlobalVariables.ProgressiveJackpotTypes.sort(function(a, b) {
                        if (a.value < b.value) {
                            return 1;
                        }
                        if (a.value > b.value) {
                            return -1;
                        }
                        return 0;
                    });
                    jackpotTypeSelect.append($('<option>', {
                        value: '',
                        text: 'All'
                    }));
                    $.each(jackpotTypeOptions, function(i, item) {
                        jackpotTypeSelect.append($('<option>', {
                            value: item.value,
                            text: item.text
                        }));
                    });

                    $('select[name="groupingType"]').change(function (e) {
                        var fromDatepicker = $("#fromDate").data("kendoDatePicker");
                        var toDatepicker = $("#toDate").data("kendoDatePicker");

                        switch($(this).val()) {
                            case 'month':
                                fromDatepicker.setOptions({
                                    start: 'year',
                                    depth: 'year',
                                    format: 'MM-yyyy'
                                });
                                fromDatepicker.value(moment(fromDatepicker.value()).date(1).hour(0).minute(0).second(0).millisecond(0).toDate());

                                toDatepicker.setOptions({
                                    start: 'year',
                                    depth: 'year',
                                    format: 'MM-yyyy'
                                });
                                toDatepicker.value(moment(toDatepicker.value()).add(1, 'months').date(0).hour(23).minute(59).second(59).millisecond(999).toDate());
                                break;
                            case 'day':
                            case 'DateRange':
                                fromDatepicker.setOptions({
                                    start: 'month',
                                    depth: 'month',
                                    format: 'dd-MM-yyyy'
                                });
                                toDatepicker.setOptions({
                                    start: 'month',
                                    depth: 'month',
                                    format: 'dd-MM-yyyy'
                                });
                                break;
                        }
                    });
                },

                //@link: http://docs.telerik.com/kendo-ui/framework/excel/extract-datasoruce
                ExportToExcel: function () {
                    tegPopups.showDaisyWheelTotalHover();

                    var gridColumns = $.extend([], TeG.Reports().Config.ProgressiveWins.drillDownColumnsArr);
                    /*
                    if ($('div[data-role="grid"][id^="reportGridDrillDownData"]').length > 0) {
                        // Son inner grid/grids was opened and we will take columns defenition from last opened grid 
                        gridColumns = $($('div[data-role="grid"][id^="reportGridDrillDownData"]')[$('div[data-role="grid"][id^="reportGridDrillDownData"]').length - 1]).data('kendoGrid').columns;
                    }
                    */
                    var excelRows = [
                    {
                        cells: []
                    }];
                    var workbookSheetsColumns = [];

                    var memberDropDown = null;
                    if (typeof ($("#master-agents").data('kendoDropDownList')) != 'undefined') {
                        memberDropDown = $("#master-agents").data('kendoDropDownList').value() || null;
                    } else if (typeof ($("#agents").data('kendoDropDownList')) != 'undefined') {
                        memberDropDown = $("#agents").data('kendoDropDownList').value() || null;
                    }

                    var fromDatepicker = $("#fromDate").data("kendoDatePicker");
                    var toDatepicker = $("#toDate").data("kendoDatePicker");

                    var fromDate = moment(fromDatepicker.value());
                    var toDate = moment(toDatepicker.value());

                    fromDate.hour(0).minute(0).second(0).millisecond(0);
                    toDate.hour(23).minute(59).second(59).millisecond(999);

                    if ($('select[name="groupingType"]').val() == 'month') {
                        toDate.add(1, 'months').date(0);
                    }

                    var data = {
                        fromDate: fromDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                        toDate: toDate.format('YYYY-MM-DDTHH:mm:ss.SSS'),
                        loginName: memberDropDown,
                        timeGroupingPeriod: $('select[name="groupingType"]').val(),
                        jackpotTypeid: ($('.jackpotTypeSelect').val() == '') ? null : parseInt($('.jackpotTypeSelect').val()),
                        currencyId: ($('#currency-type').val() == '' || typeof ($('#currency-type').val()) == 'undefined') ? null : parseInt($('#currency-type').val()),
                        // Setting isExportToExcel parameter to TRUE cancels paging feature on server side and all data is returned ( ReportsDataController.ProgressiveWins, line: 298)
                        isExportToExcel: true
                    };

                    var schema = $.extend({}, TeG.Reports().Config.ProgressiveWins.drillDownColumnsArrSchema);

                    var ds = new kendo.data.DataSource({
                        type: 'aspnetmvc-ajax',
                        transport: {
                            read: {
                                url: tegUrlHelper.progressiveWinsDetailed,
                                dataType: "json",
                                method: "POST",
                                data: data
                            }
                        },
                        serverPaging: true,
                        page: 1,
                        pageSize: 1000000,
                        schema: schema
                    });

                    $(gridColumns).each(function (key, value) {
                        if (value.field == 'MasterAgent') {
                            if (TeG.GlobalVariables.memberInfo != undefined && (TeG.GlobalVariables.memberInfo.memberTypeId == 3 || TeG.GlobalVariables.memberInfo.memberTypeId == 4)) {
                                gridColumns[key].hidden = true;
                            }
                        }
                        if (value.field == 'Agent') {
                            if (TeG.GlobalVariables.memberInfo != undefined && TeG.GlobalVariables.memberInfo.memberTypeId == 4) {
                                gridColumns[key].hidden = true;
                            }
                        }
                    });

                    // Adding headers to excel
                    $(gridColumns).each(function () {
                       // if (!this.hidden) {
                            excelRows[0].cells.push({ value: this.title });
                       // }
                    });

                    ds.fetch(function () {
                        //@this = dataSource object
                        var data = this.data();
                        // Adding data rows to excel
                        $(data).each(function() {
                            //@this = data row
                            var dataRow = this;
                            var excelCells = [];
                            $(gridColumns).each(function () {
                                //@this = column 
                               // if (!this.hidden) {
                                    switch (this.field) {
                                        case 'JackpotDate':
                                            excelCells.push({ value: dataRow[this.field], format: 'yyyy-MM-dd hh:mm:ss' });
                                            break;
                                        case 'JackpotAmount':
                                            excelCells.push({ value: dataRow[this.field], format: '#.00' });
                                            break;
                                        default:
                                            excelCells.push({ value: dataRow[this.field] });
                                            break;
                                    }
                               // }
                            });
                            excelRows.push({ cells: excelCells });
                        });

                        $(gridColumns).each(function () {
                            //@this = column 
                            workbookSheetsColumns.push({ autoWidth: true });
                        });
                        
                        var workbook = new kendo.ooxml.Workbook({
                            sheets: [
                              {
                                  columns: workbookSheetsColumns,
                                  // Title of the sheet
                                  title: TeG.Translations.TitleProgressiveWins,
                                  // Rows of the sheet
                                  rows: excelRows
                              }
                            ]
                        });

                        //save the file as Excel file with extension xlsx
                        kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: TeG.Translations.TitleProgressiveWins + ".xlsx" });
                        tegPopups.closeTotalHover();
                    });
                },

                changeMA: function(event) {
                    if (event.sender.value() == '') { //All selected in selectMA
                        $('#currency-type option[value="1"]').prop("selected", true);
                        $('#currency-type').prop('disabled', true);
                    }
                    else { //MA is selected in selectMA
                        $('#currency-type').prop('disabled', false);
                    }
                },

                DataBound: function (event) {                    
                    TeG.Reports().Common().DataBound(event);
                    // window.isDataBound = true;

                    $('#reportInterval').html($('#fromDate').val() + ' - ' + $('#toDate').val());
                    $('#reportDataTitle').show();
                    $('#reportData').show();
                    $('#reportData>div').show();
                    if (event.sender.dataSource.data().length > 0 ) {
                        $('#reportDataTitleNoData').hide();
                        $('.reportSummaryData').show();
                        $('#reportDataTitleSummary').show();
                        $('#reportInterval').show();
                        //In case of Date Range, only display summary
                        if ($('select[name="groupingType"]').val() == "DateRange") {
                            $('#reportGridData').hide();
                        }
                        else {
                            $('#reportGridData').show();
                        }
                        TeG.Reports().EnableToolBar();
                    }
                    else {
                        if (!event.sender.dataSource.filter()) {
                            // data requested by report submit and not by filtering
                            $('#reportDataTitleSummary').hide();
                            $('#reportInterval').hide();
                            $('#reportGridData').hide();
                            $('#reportDataTitleNoData').show();
                        }

                        if ($('select[name="groupingType"]').val() == "DateRange") {
                            if (ProgressiveWinsSummary) {
                                $('#reportDataTitleNoData').hide();
                                $('.reportSummaryData').show();
                                $('#reportDataTitleSummary').show();
                                $('#reportInterval').show();
                            } else {
                                $('#reportDataTitleNoData').show();
                                $('.reportSummaryData').hide();
                            }
                        }
                        TeG.Reports().DisableToolBar();
                    }

                    resizeGrid();
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    //TeG.Utils().searchBehaivor($('#GlobalSearchEdit'), gridManager.RefreshGrid);
                    splitterResize();
                    collapseMenuOnScroll();

                    // collapse expand Search Criteria
                    if (event.sender._data.length > 10 && $('#collapseBehaivor').is(':visible')) {
                        TeG.Reports().Common().ExpandCollapse();
                    }

                    //Collapse if one item in report
                    if (event.sender._data.length == 1 && typeof ($('.k-hierarchy-cell a')) != 'undefined') {
                        $('.k-hierarchy-cell a').click();
                    }

                    //Add Summary Table
                    var reportSummaryData = '';
                    if (ProgressiveWinsSummary) {
                        $.each(TeG.Reports().Config.ProgressiveWins.columnsArrSummary, function (key, value) {
                            reportSummaryData += '<div><dl><dt>' + value.title + '</dt><dd>' + ProgressiveWinsSummary[value.field] + '</dd></dl></div>';
                        });
                    }
                    $('.reportSummaryData').html(reportSummaryData);                                       
                },

                DetailExpand: function(event) {
                    var innerGrid = $('#ReportProgressiveWinsGrid_inner');

                    if (innerGrid.length > 0) {
                        innerGrid = innerGrid.data('kendoGrid');
                        innerGrid.destroy();
                        
                    }
                }

            };
        },
        //#endregion

        //#region TournamentWins
        TournamentWins: function () {

            return {
                Show: function () {
                    $('.item.searchBtnContainer').hide();

                    TeG.Reports().TournamentWins().HandleTournamentIdField();

                    $('#tournamentId').keyup(function (e) {

                        if ($(this).val() !== '') {
                            $('input#fromDate').data("kendoDatePicker").enable(false);
                            $('input#toDate').data("kendoDatePicker").enable(false);
                        } else {
                            $('input#fromDate').data("kendoDatePicker").enable(true);
                            $('input#toDate').data("kendoDatePicker").enable(true);
                        }
                    });

                    $('#searchReport').unbind(kendo.support.click).bind(kendo.support.click, function () {

                       // if ((new TeG.Validator()).IsContainerHasDisplayedErrorMessage($('#reportHeaderContainer'))) return;

                        var fromDatepicker = $("#fromDate").data("kendoDatePicker");
                        var toDatepicker = $("#toDate").data("kendoDatePicker");

                        var fromDate = moment(fromDatepicker.value());
                        var toDate = moment(toDatepicker.value());

                        fromDate.hour(0).minute(0).second(0).millisecond(0);
                        toDate.hour(23).minute(59).second(59).millisecond(000);


                        var culturesMap = {
                            //'en': 'en-US',
                            'ch': 'zh-CN',
                            'tw': 'zh-TW',
                        }

                        var TournamentWinsSummary = [];
                        var memberDropDown = null;

                        var validator = new TeG.Validator();
                        validator.CleanError($('#fromDate'));
                        validator.CleanError($('#toDate'));
                        if (!TeG.Reports().Common().ValidateData()) return;

                        if (typeof ($("#master-agents").data('kendoDropDownList')) != 'undefined') {
                            memberDropDown = $("#master-agents").data('kendoDropDownList').value() || null;
                        } else if (typeof ($("#agents").data('kendoDropDownList')) != 'undefined') {
                            memberDropDown = $("#agents").data('kendoDropDownList').value() || null;
                        }

                        var data = {
                            fromDate: $('#tournamentId').val() === "" ? fromDate.format('YYYY-MM-DDTHH:mm:ss.SSS') : null,
                            toDate: $('#tournamentId').val() === "" ? toDate.format('YYYY-MM-DDTHH:mm:ss.SSS') : null,
                            loginName: memberDropDown,
                            SponsorshipType: ($('input[name="sponsorshipType"]:checked').val() == '' || typeof ($('input[name="sponsorshipType"]:checked').val()) == 'undefined') ? null : $('input[name="sponsorshipType"]:checked').val(),
                            currencyId: ($('#currency-type').val() == '' || typeof ($('#currency-type').val()) == 'undefined') ? null : parseInt($('#currency-type').val()),
                            tournamentIdList: $('#tournamentId').val() === "" ? null : $('#tournamentId').val().split(',')
                        };

                        window.isEmptyGrid = false;
                        window.isDataBound = false;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        // Excel export
                        $('#exportLink').removeAttr('onclick');
                        $('#exportLink').unbind('click').bind('click', function (e) {
                            e.preventDefault();
                            var grid = $('#reportGridData').data('kendoGrid');
                            grid.saveAsExcel();
                        });
                        // End Excel export

                        //#region Print Report
                        /*Print Report*/
                        $('#linkPrint').click(function () {
                            printGrid([$('#reportSummary'), $("#reportGridData")]);
                        });
                        /*End - Print Report*/
                        //#endregion Print Report

                        //#region Main Grid

                        function createGrid() {
                            var columns = TeG.Reports().Config.TournamentWins.columnsArr;
                            $(columns).each(function (key, value) {
                                if (value.field == 'MasterAgent' || value.field == 'SponsorshipType') {
                                    if (TeG.GlobalVariables.memberInfo != undefined && (TeG.GlobalVariables.memberInfo.memberTypeId == 3 || TeG.GlobalVariables.memberInfo.memberTypeId == 4)) {
                                        columns[key].hidden = true;
                                        columns[key].menu = false;
                                    }
                                }
                                if (value.field == 'Agent') {
                                    if (TeG.GlobalVariables.memberInfo != undefined && TeG.GlobalVariables.memberInfo.memberTypeId == 4) {
                                        columns[key].hidden = true;
                                        columns[key].menu = false;
                                    }
                                }
                            });

                            $('#reportGridData').kendoGrid({
                                reorderable: true,
                                excel: {
                                    allPages: true,
                                    fileName: kendo.format("TournamentWins_{0}-{1}.xlsx", fromDate.format('YYYY-MM-DDTHH:mm:ss.SSS'), toDate.format('YYYY-MM-DDTHH:mm:ss.SSS')),
                                    forceProxy: true,
                                    proxyURL: tegUrlHelper.export,
                                    filterable: true
                                },
                                autoBind: false,
                                dataSource: new kendo.data.DataSource({
                                    type: 'aspnetmvc-ajax',
                                    transport: {
                                        read: {
                                            url: tegUrlHelper.TournamentWins,
                                            dataType: "json",
                                            method: "POST",
                                            data: data
                                        }
                                    },
                                    pageSize: 25,
                                    serverPaging: true,
                                    serverFiltering: true,
                                    serverSorting: true,
                                    schema: TeG.Reports().Config.TournamentWins.columnsArrSchema,
                                    sort: ({ field: "PeriodStartTimeUTC", dir: "asc" })
                                }),
                                columns: columns,

                                pageable: {
                                    pageSize: 25,
                                    pageSizes: [25, 50, 100]
                                },
                                resizable: true,
                                sortable: {
                                    allowUnsort: false
                                },
                                columnResize: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnReorder: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnShow: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                columnHide: function (e) {
                                    TeG.Grid.Options.Store(e);
                                },
                                scrollable: true,
                                filterable: true,
                                columnMenu: true,
                                dataBound: function (e) {
                                    TeG.Reports().TournamentWins().DataBound(e);
                                }
                            }).addClass('main-grid-progressive-wins');


                            var grid = $('#reportGridData').data('kendoGrid');
                            TeG.Grid.Options.Restore(grid);
                            grid.dataSource.read();
                        }

                        //#endregion Main Grid

                        // Kendo translations
                        $.getScript(location.origin + "/Scripts/kendo/" + kendo.version + "/messages/kendo.messages." + (culturesMap[culture] || 'en-US') + ".min.js", function () {
                            createGrid();
                        });
                    });
                },

                changeMA: function (event) {
                    if (event.sender.value() == '') { //All selected in selectMA
                        $('#currency-type option[value="1"]').prop("selected", true);
                        $('#currency-type').prop('disabled', true);
                    }
                    else { //MA is selected in selectMA
                        $('#currency-type').prop('disabled', false);
                    }
                },

                DataBound: function (event) {
                    TeG.Reports().Common().DataBound(event);
                    // window.isDataBound = true;

                    $('#reportInterval').html($('#fromDate').val() + ' - ' + $('#toDate').val());
                    $('#reportDataTitle').show();
                    $('#reportData').show();
                    $('#reportData>div').show();
                    if (event.sender.dataSource.data().length > 0) {
                        $('#reportDataTitleNoData').hide();
                        $('.reportSummaryData').show();
                        $('#reportDataTitleSummary').show();
                        $('#reportInterval').show();
                        $('#reportGridData').show();
                        TeG.Reports().EnableToolBar();
                    }
                    else {
                        if (!event.sender.dataSource.filter()) {
                            // data requested by report submit and not by filtering
                            $('#reportDataTitleSummary').hide();
                            $('#reportInterval').hide();
                            $('#reportGridData').hide();
                            $('#reportDataTitleNoData').show();
                        }
                        TeG.Reports().DisableToolBar();
                    }

                    resizeGrid();
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    splitterResize();
                    collapseMenuOnScroll();

                    // collapse expand Search Criteria
                    if (event.sender._data.length > 10 && $('#collapseBehaivor').is(':visible')) {
                        TeG.Reports().Common().ExpandCollapse();
                    }

                    //Collapse if one item in report
                    if (event.sender._data.length == 1 && typeof ($('.k-hierarchy-cell a')) != 'undefined') {
                        $('.k-hierarchy-cell a').click();
                    }

                    //Add Summary Table
                    var reportSummaryData = '';
                    if (TournamentWinsSummary.length > 0) {
                        $.each(TeG.Reports().Config.TournamentWins.columnsArrSummary, function (key, value) {
                            if (!(value.field == 'SponsorshipType' &&
                                TeG.GlobalVariables.memberInfo != undefined &&
                                (TeG.GlobalVariables.memberInfo.memberTypeId == 3 || TeG.GlobalVariables.memberInfo.memberTypeId == 4))) {
                                reportSummaryData += '<div><dl><dt>' + value.title + '</dt>';
                                $.each(TournamentWinsSummary, function (index, row) {
                                    reportSummaryData += '<dd>' + (row[value.field] || '0.00') + '</dd>';
                                });
                                reportSummaryData += '</dl></div>';
                            }
                        });
                    }
                    $('.reportSummaryData').html(reportSummaryData);
                },

                HandleTournamentIdField: function () {
                    $('#tournamentId').on('keyup', function (event) {

                        /**
                         * 35 - End
                         * 36 - Home
                         * 37 - Arrow left
                         * 39 - Arrow right
                         */
                        var ignoreKeysArr = [35, 36, 37, 39];

                        if ($.inArray(event.which, ignoreKeysArr) >= 0) {
                            return;
                        }

                        var originFieldVal = event.currentTarget.value;
                        var fieldVal = event.currentTarget.value;

                        // Remove alphabetical chars
                        fieldVal = fieldVal.replace(/[^0-9,]/g, "")
                        // Remove duplicated commas
                        .replace(/,{2,}/g, ',')
                        // Remove commas from start
                        .replace(/^[\,]+/g, "");

                        originFieldVal !== fieldVal && $(event.currentTarget).val(fieldVal);
                    })
                    .on('blur', function (event) {
                        var fieldVal = event.currentTarget.value;

                        // Remove alphabetical chars
                        fieldVal = fieldVal.replace(/[^0-9,]/g, "");
                        // Remove commas from start and end
                        fieldVal = fieldVal.replace(/^[\,]+|[\,]+$/g, "");
                        // Remove duplicated ids
                        var set = new Set(fieldVal.split(','));
                        fieldVal = Array.from(set).join(',');

                        $(event.currentTarget).val(fieldVal);
                    })
                    .on('mouseout', function(event) {
                        var fieldVal = event.currentTarget.value;

                        // Remove alphabetical chars
                        fieldVal = fieldVal.replace(/[^0-9,]/g, "");
                        // Remove commas from start and end
                        fieldVal = fieldVal.replace(/^[\,]+|[\,]+$/g, "");
                        // Remove duplicated ids
                        var set = new Set(fieldVal.split(','));
                        fieldVal = Array.from(set).join(',');

                        $(event.currentTarget).val(fieldVal);
                    });
                }
            };
        },
        //#endregion

        //#region CasinoEarning
        CasinoEarning: function () {
            return {
                SummaryLevelBehavior: function () {
                    function summaryLevelBehaivor() {
                        if ($('select[name="groupingType"]').val() !== 'Detailed') {
                            $('.nDailyTime').show();
                            $('.date').find('select').hide();
                        } else {
                            $('.nDailyTime').hide();
                            $('.date').find('select').show();
                        }
                    };
                    summaryLevelBehaivor();
                    $('select[name="groupingType"]').on('change', function () {
                        summaryLevelBehaivor();
                    });
                },

                Show: function (type) {
                    TeG.Reports().CasinoEarning().SummaryLevelBehavior();

                    var timezoneSelect = $('#timezone-type-select'),
                        subordinatesList = $('#subordinates-list'),
                        summaryLevel = $('#summary-level-select'),
                        optionDailyBySub = $('#daily-by-sub-option'),
                        selectedSubordinates = $('#select-subordinates').find('div');

                    timezoneSelect.change(function () {
                        if ($(this).val() === 'Parent') {
                            subordinatesList.hide();
                            optionDailyBySub.hide();
                            selectedSubordinates.removeClass('selected');
                            selectedSubordinates.first().addClass('selected');
                            if (summaryLevel.val() === 'DailyBySubordinate') {
                                summaryLevel.val('Daily');
                            }
                        } else {
                            subordinatesList.show();
                            optionDailyBySub.show();
                        }
                    });
                    $('#searchReport').on('click', function () {
                        TeG.Reports().Common().StartSearch();
                        var fromHour = ($('select[name="fromDateHour"]').is(':visible')) ? $('select[name="fromDateHour"]').val() : '00';
                        var toHour = ($('select[name="toDateHour"]').is(':visible')) ? $('select[name="toDateHour"]').val() : '23';
                        var fromMinute = ($('select[name="fromDateMinute"]').is(':visible')) ? $('select[name="fromDateMinute"]').val() : '00';
                        var toMinute = ($('select[name="toDateMinute"]').is(':visible')) ? $('select[name="toDateMinute"]').val() : '59';
                        var data = {
                            customerType: ($('input[name="customerType"]').index() != -1) ? $('input[name="customerType"]:checked').val() : 'All',
                            fromDate: TeG.Utils().convertReportDateTime($('input[name="fromDate"]').val(), fromHour, fromMinute),
                            toDate: TeG.Utils().convertReportDateTime($('input[name="toDate"]').val(), toHour, toMinute, '59.997'),
                            groupingType: $('select[name="groupingType"]').val(),
                            timezoneType: $('select[name="timezoneType"]').val()
                        };
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array()
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            })
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                }
                            }
                        }
                        if ($('#currency-type').index() != -1) {
                            if ($('#currency-type').val() == 1) {
                                data.currencyId = $('#loginCurrencyId').val();
                            }
                        }
                        if (type && type == 'HO') {
                            data.customerType = 'All';
                            var getSummaryData = TeG.Reports().GetReportSummaryDataMultiCurrency2;
                        } else {
                            var getSummaryData = TeG.Reports().GetReportSummaryData2;
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        tegPopups.showTotalHover();
                        $('#reportData').hide();
                        $('#searchReport').addClass('loading');
                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.casinoEarning, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                getSummaryData(tegUrlHelper.casinoEarningSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode)
                            });
                    });
                    if (localStorage.getItem('dailyCasinoEarningReport')) {
                        var initialData = JSON.parse(localStorage.getItem('dailyCasinoEarningReport'));
                        localStorage.removeItem('dailyCasinoEarningReport');
                        $('input[type="radio"][value="' + initialData.customerType + '"]').click();
                        $('select[name="groupingType"]').val(initialData.groupingType);
                        $('select[name="timezoneType"]').find('option[value=' + initialData.timezoneType + ']').prop('selected', true);
                        $('input[name="fromDate"]').val(initialData.day);
                        $('input[name="toDate"]').val(initialData.day);
                        if (initialData.agents) {
                            $('#select-subordinates').children().each(function () {
                                if ($(this).attr('data-value')) {
                                    var val = $(this).attr('data-value') + $(this).html();
                                } else {
                                    var val = $(this).html();
                                }
                                if ($.inArray(val, initialData.agents) != -1) {
                                    $(this).addClass('selected');
                                } else {
                                    $(this).removeClass('selected');
                                }
                            })
                        }
                        var currencyType = null;
                        if (initialData.currencyType) {
                            $('#currency-type').find('option[value=' + initialData.currencyType + ']').prop('selected', true);
                        }
                        $('.time').show();
                        $('.nDailyTime').hide();
                        $('#searchReport').click();
                    }
                },

                ShowOnTab: function () {
                    TeG.Reports().CasinoEarning().SummaryLevelBehavior();

                    $('#searchReport').on('click', function () {
                        TeG.Reports().Common().StartSearch();
                        var fromHour = ($('select[name="fromDateHour"]').is(':visible')) ? $('select[name="fromDateHour"]').val() : '00';
                        var toHour = ($('select[name="toDateHour"]').is(':visible')) ? $('select[name="toDateHour"]').val() : '23';
                        var fromMinute = ($('select[name="fromDateMinute"]').is(':visible')) ? $('select[name="fromDateMinute"]').val() : '00';
                        var toMinute = ($('select[name="toDateMinute"]').is(':visible')) ? $('select[name="toDateMinute"]').val() : '59';
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('input[name="fromDate"]').val(), fromHour, fromMinute),
                            toDate: TeG.Utils().convertReportDateTime($('input[name="toDate"]').val(), toHour, toMinute, '59.997'),
                            groupingType: $('select[name="groupingType"]').val(),
                            timezoneType: $('select[name="timezoneType"]').val(),
                            accountNumber: $('#customer-account-name').val()
                        };
                        if (!TeG.Reports().Common().ValidateData()) return;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.playerEarning, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportSummaryData2(tegUrlHelper.playerEarningSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode)
                            });
                    });
                },

                DataBound: function (event) {
                    // restoreColumnsWidthes(event);
                    if (($('select[name="groupingType"]').val() == 'Daterange' && $('#select-subordinates').index() == -1)) {
                        searchReportFlow.isReportDataVisible = false;
                    }
                    TeG.Reports().Common().DataBound(event);
                    if ($('select[name="groupingType"]').val() == 'Detailed') {
                        var nFromDate = TeG.Utils().formatDateTime($('input[name="fromDate"]').val(), $('select[name="fromDateHour"]').val(), $('select[name="fromDateMinute"]').val());
                        var nToDate = TeG.Utils().formatDateTime($('input[name="toDate"]').val(), $('select[name="toDateHour"]').val(), $('select[name="toDateMinute"]').val());
                        $('#reportInterval').html(nFromDate + ' - ' + nToDate);
                    } else {
                        $('#reportInterval').html($('input[name="fromDate"]').val() + ' - ' + $('input[name="toDate"]').val());
                    }
                    if ($('select[name="groupingType"]').val() == 'Daily') {
                        $('.casinoEarningDate').on('click', function () {
                            var agents = new Array();
                            if ($('#select-subordinates').index() != -1) {
                                $('#select-subordinates').children().each(function () {
                                    if ($(this).hasClass('selected')) {
                                        if ($(this).attr('data-value')) {
                                            var val = $(this).attr('data-value') + $(this).html();
                                        } else {
                                            var val = $(this).html();
                                        }
                                        agents.push(val);
                                    }
                                })
                            }
                            var currencyType = null;
                            if ($('#currency-type').index() != -1) {
                                currencyType = $('#currency-type option:selected').val();
                            }
                            var storage_data = {
                                day: $(this).html(),
                                customerType: $('input[name="customerType"]:checked').val(),
                                timezoneType: $('select[name="timezoneType"] option:selected').val(),
                                agents: agents,
                                currencyType: currencyType,
                                groupingType: $('select[name="groupingType"]').val()
                            }
                            localStorage.setItem('dailyCasinoEarningReport', JSON.stringify(storage_data));
                            window.open(window.location.href, '_blank');
                        });
                    } else {
                        $('.casinoEarningDate').removeClass('casinoEarningDate');
                    }
                    if ($('select[name="groupingType"]').val() == 'Detailed') {
                        $('.casinoEarningReceiptNumber').on('click', function (event) {
                            TeG.Popups().receipt().get($.trim($(this).html())).show();
                        });
                    } else {
                        $('.casinoEarningReceiptNumber').removeClass('casinoEarningReceiptNumber');
                    }
                    $.each($('.customerTypeIcon '), function (key, value) {
                        if ($(value).html() == 'Station') {
                            $(value).html('<img src = "/Images/icStation.png" />');
                        } else {
                            $(value).html('<img src = "/Images/icPlayer.png" />');
                        }
                    });
                    if ($('#currency-type').index() != -1 && $('select[name="groupingType"]').val() != 'Daily') {
                        $('.casinoEarningCurrency').off();
                        $('.casinoEarningCurrency').on('click', { that: this }, function (event) {
                            var that = event.data.that;
                            var fromHour = ($('select[name="fromDateHour"]').is(':visible')) ? $('select[name="fromDateHour"]').val() : '00';
                            var toHour = ($('select[name="toDateHour"]').is(':visible')) ? $('select[name="toDateHour"]').val() : '23';
                            var fromMinute = ($('select[name="fromDateMinute"]').is(':visible')) ? $('select[name="fromDateMinute"]').val() : '00';
                            var toMinute = ($('select[name="toDateMinute"]').is(':visible')) ? $('select[name="toDateMinute"]').val() : '59';
                            var data = {};
                            data.LoginName = $('#ReportCasinoEarningGrid1Grid').data('kendoGrid').dataSource.at($(this).closest("tr").index()).LoginName;
                            data.FromDate = TeG.Utils().convertReportDateTime($('input[name="fromDate"]').val(), fromHour, fromMinute);
                            data.ToDate = TeG.Utils().convertReportDateTime($('input[name="toDate"]').val(), toHour, toMinute, '59.997');
                            data.BaseCurrencyId = $('#loginCurrencyId').val();
                            tegPopups.showDaisyWheelTotalHover();
                            $.ajax({
                                url: tegUrlHelper.getEffectiveRates,
                                type: "POST",
                                data: JSON.stringify(data),
                                dataType: 'json',
                                contentType: "application/json; charset=utf-8",
                                error: function (jqXHR) {
                                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                    tegErrorHandler.processError(jqXHR);
                                }
                            }).done(function (data) {
                                tegPopups.totalHoverRemoveDaisyWheel();
                                if (typeof (currencyRateViewModel) == 'undefined') {
                                    currencyRateViewModel = { currencyRate: ko.observableArray(), isoName: ko.observable($('#loginCurrencyISOName').val()) }  // must be in global scope
                                    ko.applyBindings(currencyRateViewModel, $('#popup-currency-rate').get(0));
                                }
                                currencyRateViewModel.currencyRate.removeAll();
                                $(data.Data).each(function () {
                                    currencyRateViewModel.currencyRate.push(this)
                                }
                                )
                                $('#popup-currency-rate').show();
                                $('#popup-currency-rate-close').focus();
                                $('#popup-currency-rate-close').off();
                                $('#popup-currency-rate-close').on('click', function () {
                                    $('#popup-currency-rate').hide();
                                    tegPopups.closeTotalHover();
                                });
                            });
                        });
                    } else {
                        $('.casinoEarningCurrency').removeClass('casinoEarningCurrency');
                    }
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        if (!($('select[name="groupingType"]').val() == 'Daterange' && $('#select-subordinates').index() == -1)) {
                            gridPrint.setGrid($('#ReportCasinoEarningGrid1Grid').data('kendoGrid'));
                        }
                        gridPrint.setTitle('Casino Earning Report');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                },

                DataBoundOnTab: function (event) {
                    $('.call-pca-popup').removeClass('call-pca-popup');
                    $('.casinoEarningDate').removeClass('casinoEarningDate');
                    TeG.Reports().CasinoEarning().DataBound(event);
                    splitterResize();
                }
            };
        },
        //#endregion

        //#region CreditTransfer
        CreditTransfer: function () {
            return {
                Show: function () {
                    if (typeof (requestViewModel) === 'undefined') {
                        requestViewModel = {
                            transactionType: ko.observable('All'),
                            groupingType: ko.observable('Detailed'),
                            subordinates: ko.observable('')
                        };
                    }
                    requestViewModel.selectSubordinate$visible = ko.computed(function () {
                        return this.transactionType() == 'MasterAgentTransaction' || this.transactionType() == 'Agenttransaction';
                    }, requestViewModel);
                    if (!ko.dataFor($('#reportHeaderContainer')[0])) {
                        ko.applyBindings(requestViewModel, $('#reportHeaderContainer')[0]);
                    }
                    $('#searchReport').on('click', { viewModel: requestViewModel }, function (event) {
                        TeG.Reports().Common().StartSearch();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", '59.997'),
                            transactionType: event.data.viewModel.transactionType(),
                            groupingType: event.data.viewModel.groupingType()
                        };

                        if (event.data.viewModel.selectSubordinate$visible()) {
                            var subordinates = new Array()
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            });
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                    requestViewModel.subordinates = data.entityDelimitedList;
                                }
                            }
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        window.isEmptyGrid = false;
                        window.isDataBound = false;
                        $('#reportData').hide();
                        $('#openingBalance').html('');
                        $('#closingBalance').html('');
                        $('#changeBalance').html('').parent().removeClass('redUnderline').removeClass('greenUnderline');
                        $('#reportSummaryFromDate').html('');
                        $('#reportSummaryToDate').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.creditTransfer, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportCreditTransferSummaryData(tegUrlHelper.creditTransferSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode, data.groupingType)
                            });
                    });
                    if (localStorage.getItem('dailyCreditTransferReport')) {
                        var initialData = JSON.parse(localStorage.getItem('dailyCreditTransferReport'));
                        if (initialData.transactionType === 'AdministratorTransaction') {
                            initialData.transactionType = 'Administrator';
                        } else if (initialData.transactionType === 'AgentTransaction') {
                            initialData.transactionType = 'Agenttransaction';
                        }

                        if (initialData.entityDelimitedList) {
                            var subordinatesList = initialData.entityDelimitedList.split(',');
                            $('#select-subordinates > div').removeClass('selected');
                            $.each($('#select-subordinates > div'), function (key, val) {
                                if ($.inArray($(val).data('value'), subordinatesList) !== -1) {
                                    $(val).addClass('selected');
                                }
                            });
                        }
                        localStorage.removeItem('dailyCreditTransferReport');
                        requestViewModel.groupingType('Detailed');
                        requestViewModel.transactionType(initialData.transactionType);
                        $('input[name="fromDate"]').val(initialData.day);
                        $('input[name="toDate"]').val(initialData.day);
                        $('#searchReport').click();
                    }
                },

                DataBound: function (event) {

                    restoreColumnsWidthes(event);

                    TeG.Reports().Common().DataBound(event);
                    window.isDataBound = true;
                    if ($('.receiptNumberTransferPopup').length > 0) {
                        $.each($('.receiptNumberTransferPopup'), function (key, val) {
                            $(val).html($(val).html().replace(/[^0-9]/g, ''));
                        })
                        $('.receiptNumberTransferPopup').off()
                        $('.receiptNumberTransferPopup').on('click', function (event) {
                            TeG.Popups().receipt().get($.trim($(this).html())).show();
                        });
                    };
                    $.each($('.transactionTypeIcon '), function (key, value) {
                        /*
                         Head Office transaction
                         Master Agent transaction
                         Agent transaction
                         Head Office Reconciliation
                         Master Agent Reconciliation
                         Agent Reconciliation
                         Station Transaction 
                         Player Transaction
                         */
                        if ($.trim($(value).html()) == 'Station Transaction') {
                            $(value).html('<img src = "/Images/icStation.png" data-transactionType="StationTransaction" title="' + TeG.Translations.ReportOptionStationTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Player Transaction') {
                            $(value).html('<img src = "/Images/icPlayer.png" data-transactionType="PlayerTransaction" title="' + TeG.Translations.ReportOptionPlayerTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Agent transaction') {
                            $(value).html('<img src = "/Images/icAgent.png" data-transactionType="AgentTransaction" title="' + TeG.Translations.ReportOptionAgentTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Master Agent transaction') {
                            $(value).html('<img src = "/Images/icMasterAgent.png" data-transactionType="MasterAgentTransaction" title="' + TeG.Translations.ReportOptionMasterAgentTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Administrator') {
                            $(value).html('<img src = "/Images/icAdministrator.png" data-transactionType="AdministratorTransaction" title="' + TeG.Translations.ReportOptionAdministratorTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Head Office transaction') {
                            // TODO: clarify string "Head Office transaction"
                            $(value).html('<img src = "/Images/icHeadOffice.png" data-transactionType="HeadOfficetransaction" title="' + TeG.Translations.ReportOptionHeadOfficeTransaction + '" />');
                        }
                    });

                    if ($('select[name="groupingType"]').val() == 'Daily') {
                        $('.transferReportDate').on('click', function (event) {
                            var storage_data = {
                                day: $(this).html(),
                                customerType: $('input[name="customerType"]:checked').val(),
                                transactionType: $(this).next().find('img').data('transactiontype'),
                                entityDelimitedList: requestViewModel.subordinates
                            };
                            localStorage.setItem('dailyCreditTransferReport', JSON.stringify(storage_data));
                            window.open(window.location.href, '_blank');
                        });
                    } else {
                        $('.transferReportDate').removeClass('transferReportDate');
                    }
                    $.each($('.nBalanceChange'), function (key, value) {
                        if (/\-/.test($(value).html())) {
                            $(value).html($(value).html().replace(/\-/, '<span class="boldText">&#8722;</span> '));
                        } else {
                            $(value).html($(value).html());
                        }
                    });
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', function () {
                        var printReport = new TeG.Print('ReportCreditTransferGrid1Grid');
                        printReport.Storage().StorageReportTitle('CreditTransfer').Open(tegUrlHelper.creditTransferReport);
                    });
                }
            };
        },
        //#endregion

        //#region CreditTransferLocation
        CreditTransferLocation: function () {
            return {
                Show: function () {
                    $("#expandSearchCriteria").off();
                    $('#collapseBehaivor').off();
                    $('#expandBehaivor').off();

                    reportViewModel = creditTransferLocationReportViewModel
                    if (localStorage.getItem('dailyCreditTransferLocationReport')) {
                        reportViewModel.initFromStorage(JSON.parse(localStorage.getItem('dailyCreditTransferLocationReport')));
                        localStorage.removeItem('dailyCreditTransferLocationReport');
                        $(function () {
                            $('#searchReport').click();
                        });
                    }
                    reportViewModel.activate($('#report').get(0));
                    $(".date [name='fromDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $(".date [name='toDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $('#searchReport').on('click', function () {
                        reportViewModel.searchStart();
                        tegPopups.showTotalHover();
                        var sendData = {};
                        sendData.fromDate = reportViewModel.date.getFromDate();
                        sendData.toDate = reportViewModel.date.getToDate();
                        sendData.transactionType = reportViewModel.transactionType();
                        sendData.groupingType = reportViewModel.groupingType();
                        sendData.locationList = reportViewModel.location.getSelectedArray();
                        TeG.Reports().GetReportData(JSON.stringify(sendData), tegUrlHelper.creditTransferLocation, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportCreditTransferLocationSummaryData(tegUrlHelper.creditTransferLocationSummary + '?reportParametersHashCode='
                                        + reportParametersHashCode, sendData.groupingType)
                            });
                    })
                },

                DataBound: function (event) {
                    restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);

                    // TODO: put below code in method (common part)
                    if ($('.receiptNumberTransferPopup').length > 0) {
                        $.each($('.receiptNumberTransferPopup'), function (key, val) {
                            $(val).html($(val).html().replace(/[^0-9]/g, ''));
                        })
                        $('.receiptNumberTransferPopup').off()
                        $('.receiptNumberTransferPopup').on('click', function (event) {
                            TeG.Popups().receipt().get($.trim($(this).html())).show();
                        });
                    };
                    $.each($('.transactionTypeIcon '), function (key, value) {
                        /*
                         Head Office transaction
                         Master Agent transaction
                         Agent transaction
                         Head Office Reconciliation
                         Master Agent Reconciliation
                         Agent Reconciliation
                         Station Transaction 
                         Player Transaction
                         */
                        if ($.trim($(value).html()) == 'Station Transaction') {
                            $(value).html('<img src = "/Images/icStation.png" data-transactionType="StationTransaction" title="' + TeG.Translations.ReportOptionStationTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Player Transaction') {
                            $(value).html('<img src = "/Images/icPlayer.png" data-transactionType="PlayerTransaction" title="' + TeG.Translations.ReportOptionPlayerTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Agent transaction') {
                            $(value).html('<img src = "/Images/icAgent.png" data-transactionType="AgentTransaction" title="' + TeG.Translations.ReportOptionAgentTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Master Agent transaction') {
                            $(value).html('<img src = "/Images/icMasterAgent.png" data-transactionType="MasterAgentTransaction" title="' + TeG.Translations.ReportOptionMasterAgentTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Administrator') {
                            $(value).html('<img src = "/Images/icAdministrator.png" data-transactionType="AdministratorTransaction" title="' + TeG.Translations.ReportOptionAdministratorTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Head Office transaction') {
                            // TODO: clarify string "Head Office transaction"
                            $(value).html('<img src = "/Images/icHeadOffice.png" data-transactionType="Head Office transaction" title="' + TeG.Translations.ReportOptionHeadOfficeTransaction + '" />');
                        }
                        TeG.Reports.grid1.grid.dataSource._data[key].TransactionType = $(value).html();
                    });

                    if ($('select[name="groupingType"]').val() == 'Daily') {
                        $('.transferReportDate').on('click', function (event) {
                            var rowNumber = $(this).closest('tr').prevAll().length;
                            var storage_data = {
                                day: $(this).html(),
                                transactionType: $(this).parent().find('img').eq(0).attr('data-transactionType'),
                                location: $('#ReportCreditTransferLocationGrid1Grid').data('kendoGrid').dataSource._data[rowNumber].Location
                            }
                            localStorage.setItem('dailyCreditTransferLocationReport', JSON.stringify(storage_data));
                            window.open(window.location.href, '_blank');
                        });
                    } else {
                        $('.transferReportDate').removeClass('transferReportDate');
                    }
                    $.each($('.nBalanceChange'), function (key, value) {
                        if (/\-/.test($(value).html())) {
                            $(value).html($(value).html().replace(/\-/, '<span class="greenText boldText">&#8722;&nbsp</span> '))
                        } else {
                            $(value).html('<span class="redText boldText">+&nbsp</span> ' + $(value).html())
                        }
                    });
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        // TODO: store summary in individual method
                        var sign = (reportViewModel.changeBalancePlus$visible()) ? '-' : '';
                        var summary = {};
                        summary.reportSummaryData$visible = true;
                        summary.summaryData = [
                            { caption: $('#opening-balance-caption').html(), value: reportViewModel.openingBalanceValue() },
                            { caption: $('#closing-balance-caption').html(), value: reportViewModel.closingBalanceValue() },
                            { caption: $('#change-balance-caption').html(), value: sign + reportViewModel.changeBalanceValue() }
                        ];
                        sessionStorage.setItem('printReportSummaryData', JSON.stringify(summary));

                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportCreditTransferLocationGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Credit Transfer by Location');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region CreditTransferProgressive
        CreditTransferProgressive: function () {
            return {
                Show: function () {
                    if (localStorage.getItem('dailyCreditTransferProgressiveReport')) {
                        reportViewModel.initFromStorage(JSON.parse(localStorage.getItem('dailyCreditTransferProgressiveReport')));
                        localStorage.removeItem('dailyCreditTransferProgressiveReport');
                        $(function () {
                            $('#searchReport').click();
                        });
                    }
                    $(".date [name='fromDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $(".date [name='toDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $('#searchReport').on('click', function () {
                        reportViewModel.searchStart();
                        tegPopups.showTotalHover();
                        var sendData = {};
                        sendData.fromDate = reportViewModel.date.getFromDate();
                        sendData.toDate = reportViewModel.date.getToDate();
                        TeG.Reports().GetReportData(JSON.stringify(sendData), tegUrlHelper.creditTransferProgressive, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportCreditTransferLocationSummaryData(tegUrlHelper.creditTransferProgressiveSummaryRead + '?reportParametersHashCode='
                                        + reportParametersHashCode);
                            }
                        );
                    });
                },

                DataBound: function (event) {
                    restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);

                    $('.transferReportDate').removeClass('transferReportDate');
                    if (TeG.Reports.grid1.grid.dataSource._total > 0) {
                        TeG.Reports().Common().ReplaceTypesByIcons('TransactionType', TeG.Reports.grid1.grid.dataSource);
                    }

                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        // TODO: store summary in individual method
                        var sign = (reportViewModel.changeBalancePlus$visible()) ? '-' : '';
                        var summary = {};
                        summary.reportSummaryData$visible = true;
                        summary.summaryData = [
                            { caption: $('#opening-balance-caption').html(), value: reportViewModel.openingBalanceValue() },
                            { caption: $('#closing-balance-caption').html(), value: reportViewModel.closingBalanceValue() },
                            { caption: $('#change-balance-caption').html(), value: sign + reportViewModel.changeBalanceValue() }
                        ];
                        sessionStorage.setItem('printReportSummaryData', JSON.stringify(summary));

                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportCreditTransferProgressiveGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Progressive Credit Transfer Report');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            };
        },
        //#endregion

        //#region CasinoTransactionLocationReport
        CasinoTransactionLocationReport: function () {
            return {
                Show: function () {
                    $("#expandSearchCriteria").off();
                    $('#collapseBehaivor').off();
                    $('#expandBehaivor').off();
                    reportViewModel = casinoTransactionLocationReport;
                    if (localStorage.getItem('storeCasinoTransactionLocationReport')) {
                        reportViewModel.initFromStorage(JSON.parse(localStorage.getItem('storeCasinoTransactionLocationReport')));
                        localStorage.removeItem('storeCasinoTransactionLocationReport');
                        $(function () {
                            $('#searchReport').click()
                        });
                    }
                    // dailyCasinoTransactionLocationReport
                    reportViewModel.activate($('#report').get(0));
                    $(".date [name='fromDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $(".date [name='toDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });
                    $('#searchReport').on('click', function () {
                        reportViewModel.searchStart();
                        tegPopups.showTotalHover();
                        sendData = {};
                        sendData.fromDate = reportViewModel.date.getFromDate();
                        sendData.toDate = reportViewModel.date.getToDate();
                        sendData.groupingType = reportViewModel.groupingType();
                        sendData.customerType = reportViewModel.customerType();
                        sendData.locations = reportViewModel.location.getSelectedArray();
                        TeG.Reports().GetReportData(JSON.stringify(sendData), tegUrlHelper.casinoTransactionLocation, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportSummaryDataKO(tegUrlHelper.casinoTransactionLocationSummary + '?reportParametersHashCode='
                                    + reportParametersHashCode)
                            });
                    });
                },

                DataBound: function (event) {
                    restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);
                    $.each($('.transactionTypeIcon '), function (key, value) {
                        if ($.trim($(value).html()) == 'Station') {
                            $(value).html('<img src = "/Images/icStation.png" data-transactionType="StationTransaction" title="' + TeG.Translations.ReportOptionStationTransaction + '" />');
                        } else if ($.trim($(value).html()) == 'Player') {
                            $(value).html('<img src = "/Images/icPlayer.png" data-transactionType="PlayerTransaction" title="' + TeG.Translations.ReportOptionPlayerTransaction + '" />');
                        }
                        TeG.Reports.grid1.grid.dataSource._data[key].CustomerType = $(value).html();
                    });
                    if (sendData.groupingType == 'Daily') {
                        $('.transferReportDate').on('click', function (event) {
                            var rowNumber = $(this).closest('tr').prevAll().length;
                            var storage_data = {
                                customerType: sendData.customerType,
                                location: [$(this).next().html()],
                                fromDate: $(this).html(),
                                toDate: $(this).html(),
                                groupingType: 'Detailed'
                            };
                            localStorage.setItem('storeCasinoTransactionLocationReport', JSON.stringify(storage_data));
                            window.open(window.location.href, '_blank');
                        });
                    } else {
                        $('.transferReportDate').removeClass('transferReportDate');
                    }
                    if (sendData.groupingType == 'Daterange') {
                        $('.locationRef').on('click', function (event) {
                            var rowNumber = $(this).closest('tr').prevAll().length;
                            var storage_data = {
                                location: [$(this).html()],
                                customerType: sendData.customerType,
                                fromDate: sendData.fromDate.replace(/(\d{4})-(\d{2})-(\d{2})(T.*)$/, '$3-$2-$1'),
                                toDate: sendData.toDate.replace(/(\d{4})-(\d{2})-(\d{2})(T.*)$/, '$3-$2-$1'),
                                groupingType: 'Daily'
                            }
                            localStorage.setItem('storeCasinoTransactionLocationReport', JSON.stringify(storage_data));
                            window.open(window.location.href, '_blank');
                        });
                    } else {
                        $('.locationRef').removeClass('locationRef');
                    }

                    if (sendData.groupingType == 'Detailed') {
                        $('.casinoEarningReceiptNumber').on('click', function (event) {
                            TeG.Popups().receipt().get($.trim($(this).html())).show();
                        });
                    } else {
                        $('.casinoEarningReceiptNumber').removeClass('casinoEarningReceiptNumber');
                    }

                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#' + getReportGrid1Name()).data('kendoGrid'));
                        gridPrint.setTitle('Transaction by Location');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region GamePlayLocationReport
        GamePlayLocationReport: function () {

            function setGUIDefaults() {

                // Show search form
                reportViewModel.displayRequest(true);
                // Hide report
                reportViewModel.reportData$visible(false);

                // Remove error messages
                reportViewModel.date.fromDateError$visible(false);
                reportViewModel.date.fromDateError$css(false);
                reportViewModel.date.toDateError$visible(false);
                reportViewModel.date.toDateError$css(false);

                // Remove loading from "Search" button
                reportViewModel.loading$class(false)

                $("#expandSearchCriteria").off();
                $('#collapseBehaivor').off();
                $('#expandBehaivor').off();
            }

            function getMinFromDate() {
                var minFromDate = new Date();
                var minFromDateMonth = minFromDate.getMonth();
                var minFromDateMinMonth = minFromDateMonth - 2;

                if (minFromDateMinMonth < 0) {
                    // We have to reduce YEAR
                    minFromDate.setFullYear(minFromDate.getFullYear() - 1)
                    minFromDate.setMonth(minFromDateMinMonth + 11);
                } else {
                    minFromDate.setMonth(minFromDateMinMonth);
                }
                return minFromDate;
            }

            var initModel = {};
            initModel.Menu = function () {
                reportViewModel.customerType = ko.observable('Station');
                reportViewModel.groupingType = ko.observable('Daily');

                reportViewModel.date = new TeG.KO.FromDateToDateWithTime;
                reportViewModel.date.fromDate(reportViewModel.date.getCurrentDate());
                reportViewModel.date.dateTimeFixed$visible(true);
                reportViewModel.date.dateTimeMinutesFixed$visible = ko.observable(false);

                reportViewModel.date.dateTimeHours$visible = ko.observable(false);
                reportViewModel.date.dateTimeHours$enable = ko.observable(true);

                reportViewModel.fromDateSearch = ko.observable('');
                reportViewModel.toDateSearch = ko.observable('');

                reportViewModel.summaryReportInterval = ko.observable();

                reportViewModel.groupingType.subscribe(function (newValue) {
                    if (newValue == 'Detailed') {
                        reportViewModel.date.dateTimeHours$visible(true);
                        reportViewModel.date.dateTimeFixed$visible(false);
                        reportViewModel.date.dateTimeMinutesFixed$visible(true);
                    } else if (newValue == 'Daily') {
                        reportViewModel.date.dateTimeHours$visible(false);
                        reportViewModel.date.dateTimeFixed$visible(true);
                        reportViewModel.date.dateTimeMinutesFixed$visible(false);
                    }
                }, self);
            };

            initModel.AccountDetails = function () {
                function getCustomerType() {
                    switch (location.pathname.split('/')[location.pathname.split('/').length - 1]) {
                        case 'PlayersList':
                            return 'Player';
                            break;
                        case 'StationsList':
                            return 'Station';
                            break;
                        default:
                            return 'Player';
                            break;
                    }
                }

                reportViewModel.date = new TeG.KO.FromDateToDateWithTime;
                reportViewModel.date.fromDate(reportViewModel.date.getCurrentDate());
                reportViewModel.date.dateTimeFixed$visible(false);
                reportViewModel.date.dateTime$visible(false);
                reportViewModel.fromDateSearch = ko.observable('');
                reportViewModel.toDateSearch = ko.observable('');

                reportViewModel.groupingType = ko.observable('Detailed');
                reportViewModel.customerType = ko.observable(getCustomerType());

                reportViewModel.date.dateTimeHours$visible = ko.observable(true);
                reportViewModel.date.dateTimeHours$enable = ko.observable(true);

                reportViewModel.date.dateTimeMinutesFixed$visible = ko.observable(true);

                reportViewModel.summaryReportInterval = ko.observable();
            }

            var reportDate = {};
            reportDate.Menu = {};
            reportDate.AccountDetails = {};
            reportDate.Menu.Daily = function () {
                var FromDate = reportViewModel.date.fromDate().split('-').reverse().join('-') + 'T00:00:00.000';
                var ToDate = reportViewModel.date.toDate().split('-').reverse().join('-') + 'T23:59:59.000';
                var SummaryFormated = '{FromDate} 00:00 - {ToDate} 23:59'
                        .replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-'))
                        .replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'));
                var PrintTitleFormated = {
                    FromDate: '{FromDate} 00:00'.replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-')),
                    ToDate: '{ToDate} 23:59'.replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'))
                };
                return { FromDate: FromDate, ToDate: ToDate, SummaryFormated: SummaryFormated, PrintTitleFormated: PrintTitleFormated };
            };
            reportDate.Menu.Detailed = function () {
                var FromDate = reportViewModel.date.fromDate().split('-').reverse().join('-') + 'T' + leadingZero(reportViewModel.date.fromDateHour(), 2) + ':00:00.000';
                var ToDate = reportViewModel.date.toDate().split('-').reverse().join('-') + 'T' + leadingZero(reportViewModel.date.toDateHour(), 2) + ':59:59.000';
                var SummaryFormated = '{FromDate} {FromHour}:00 - {ToDate} {ToHour}:59'
                        .replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-'))
                        .replace('{FromHour}', leadingZero(reportViewModel.date.fromDateHour(), 2))
                        .replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'))
                        .replace('{ToHour}', leadingZero(reportViewModel.date.toDateHour(), 2));
                var PrintTitleFormated = {
                    FromDate: '{FromDate} {FromHour}:00'
                        .replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-'))
                        .replace('{FromHour}', leadingZero(reportViewModel.date.fromDateHour(), 2)),
                    ToDate: '{ToDate} {ToHour}:59'
                        .replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'))
                        .replace('{ToHour}', leadingZero(reportViewModel.date.toDateHour(), 2))
                };
                return { FromDate: FromDate, ToDate: ToDate, SummaryFormated: SummaryFormated, PrintTitleFormated: PrintTitleFormated };
            };
            reportDate.AccountDetails.Detailed = function () {
                var FromDate = reportViewModel.date.fromDate().split('-').reverse().join('-') + 'T' + leadingZero(reportViewModel.date.fromDateHour(), 2) + ':00:00.000';
                var ToDate = reportViewModel.date.toDate().split('-').reverse().join('-') + 'T' + leadingZero(reportViewModel.date.toDateHour(), 2) + ':59:59.000';
                var SummaryFormated = '{FromDate} {FromHour}:00 - {ToDate} {ToHour}:59'
                        .replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-'))
                        .replace('{FromHour}', leadingZero(reportViewModel.date.fromDateHour(), 2))
                        .replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'))
                        .replace('{ToHour}', leadingZero(reportViewModel.date.toDateHour(), 2));
                var PrintTitleFormated = {
                    FromDate: '{FromDate} {FromHour}:00'
                        .replace('{FromDate}', reportViewModel.date.fromDate().split('-').reverse().join('-'))
                        .replace('{FromHour}', leadingZero(reportViewModel.date.fromDateHour(), 2)),
                    ToDate: '{ToDate} {ToHour}:59'
                        .replace('{ToDate}', reportViewModel.date.toDate().split('-').reverse().join('-'))
                        .replace('{ToHour}', leadingZero(reportViewModel.date.toDateHour(), 2))
                };
                return { FromDate: FromDate, ToDate: ToDate, SummaryFormated: SummaryFormated, PrintTitleFormated: PrintTitleFormated };
            }

            return {
                Show: function (settings) {
                    var settings = settings;

                    reportViewModel = gamePlayLocationReport;
                    initModel[settings.mode]();
                    setGUIDefaults();

                    reportViewModel.activate($('#report').get(0));
                    $(".date [name='fromDate']").kendoDatePicker({
                        format: "dd-MM-yyyy",
                        min: getMinFromDate()
                    });
                    $(".date [name='toDate']").kendoDatePicker({
                        format: "dd-MM-yyyy"
                    });

                    $('#searchReport').on('click', function (event) {
                        var mode = $(event.target).attr('name');

                        reportViewModel.searchStart();
                        tegPopups.showTotalHover();

                        sendData = {};
                        sendData.fromDate = reportDate[mode][reportViewModel.groupingType()]().FromDate;
                        sendData.toDate = reportDate[mode][reportViewModel.groupingType()]().ToDate;
                        sendData.groupingType = reportViewModel.groupingType();
                        sendData.customerType = reportViewModel.customerType();
                        if (mode == 'AccountDetails') {
                            sendData.accountNo = TeG.AccountDetails.account;
                        }

                        // Dates validation ( from date can not bigger then to date).
                        if (new Date(sendData.fromDate) > new Date(sendData.toDate)) {
                            reportViewModel.date.fromDateError(TeG.Translations.ErrorMessageStartDateMustPrecedeEndDate);
                            reportViewModel.date.fromDateError$visible(true);
                            reportViewModel.date.fromDateError$css(true);
                            tegPopups.closeTotalHover();
                            $('#searchReport').removeClass('loading').blur();
                        } else {
                            TeG.Reports().GetReportData(JSON.stringify(sendData), tegUrlHelper.gamePlayLocation, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                // Setting summary content
                                reportViewModel.summaryReportInterval(reportDate[mode][reportViewModel.groupingType()]().SummaryFormated);
                            });
                        }
                    });
                },

                DataBound: function (event) {
                    restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);
                    $.each($('td.customerTypeIcon'), function (key, value) {
                        if ($.trim($(value).html()) == 'Station') {
                            $(value).html('<img src = "/Images/icStation.png" data-customerType="Station" title="' + TeG.Translations.StationTitle + '" />');
                        } else if ($.trim($(value).html()) == 'Player') {
                            $(value).html('<img src = "/Images/icPlayer.png" data-customerType="Player" title="' + TeG.Translations.PlayerTitle + '" />');
                        }
                        TeG.Reports.grid1.grid.dataSource._data[key].CustomerType = $(value).html();
                    });

                    if (sendData.groupingType == 'Daily') {
                        $.each($('td.gamePlayDate'), function () {
                            var tdgamePlayDate = $(this);
                            tdgamePlayDate.html(/^\d{2}-\d{2}-\d{4}/.exec(tdgamePlayDate.html()));
                        });
                    } else if (sendData.groupingType == 'Detailed') {
                        $.each($('td.gamePlayDate'), function () {
                            var tdgamePlayDate = $(this);
                            tdgamePlayDate.html(/^\d{2}-\d{2}-\d{4} \d{2}:\d{2}/.exec(tdgamePlayDate.html()));
                        });
                    }

                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {

                        function getTitleData() {
                            var titleData = {};

                            if (reportViewModel.groupingType() == 'Detailed') {
                                titleData.fromDate = reportDate.Menu.Detailed().PrintTitleFormated.FromDate;
                                titleData.toDate = reportDate.Menu.Detailed().PrintTitleFormated.ToDate;
                            }
                            return titleData;
                        }
                        var grid = $('div[data-role = "grid"]').data('kendoGrid');


                        TeG.Reports().StoreTitle(undefined, getTitleData());
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid(grid);
                        gridPrint.setTitle(TeG.Translations.MenuGamePlayLocationReport);
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region ProgressiveGamePlay
        ProgressiveGamePlay: function () {
            return {
                Show: function (type) {
                    $('#searchReport').on('click', { that: this }, function (event) {
                        TeG.Reports().Common().StartSearch();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", "59.997"),
                            customerType: ($('#reportHeaderContainer').find('input[name="customerType"]').index() != -1) ? $('#reportHeaderContainer').find('input[name="customerType"]:checked').val() : 'All',
                            groupingType: ($('#reportHeaderContainer').find('select[name="groupingType"]').index() != -1) ? $('#reportHeaderContainer').find('select[name="groupingType"]').val() : 'ByMember'
                        };
                        TeG.Reports.requestData = data;
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array()
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            })
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                }
                            }
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');
                        if (type && type == 'HO') {
                            var summaryMethod = TeG.Reports().GetReportSummaryDataMultiCurrency2;
                        } else {
                            var summaryMethod = TeG.Reports().GetReportSummaryData2;
                        }
                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.progressiveGamePlay, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                summaryMethod(tegUrlHelper.progressiveGamePlaySummaryRead + '?reportParametersHashCode=' + reportParametersHashCode)
                            });
                    });
                },

                ShowOnTab: function (type) {
                    $('#searchReport').on('click', { that: this }, function (event) {
                        TeG.Reports().Common().StartSearch();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", "59.997"),
                            accountNumber: $('#customer-account-name').val()
                        };

                        TeG.Reports.requestData = data;
                        if (!TeG.Reports().Common().ValidateData()) return;
                        $('#reportGridTitleNoData').hide();
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportGridData').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');

                        TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.playerProgressiveGamePlay, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                TeG.Reports().GetReportSummaryData2(tegUrlHelper.playerProgressiveGamePlaySummaryRead + '?reportParametersHashCode=' + reportParametersHashCode);
                            });
                    });
                },

                DataBound: function (event) {
                    //restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBound(event);
                    // pca report part
                    $('.call-pca-popup').off();
                    $('.call-pca-popup').on('click', { that: this }, function (event) {
                        event.data.that.PcaPopupActivate(event, this);
                    });
                    // print part
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportProgressiveGamePlayGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Progressive Game Play');
                        gridPrint.store();
                        gridPrint.openReport();
                    })
                },

                DataBoundOnTab: function (event) {
                    $('.call-pca-popup').removeClass('call-pca-popup');
                    TeG.Reports().ProgressiveGamePlay().DataBound(event);
                    splitterResize();
                },

                PcaPopupActivate: function (event, elem) {
                    TeG.Popups2.showTotalHover();
                    var rowIndex = $(elem).closest('tr').index();
                    var kendoData = $('#ReportProgressiveGamePlayGrid1Grid').data('kendoGrid').dataSource.at(rowIndex);
                    var sendData = {
                        fromDate: TeG.Reports.requestData.fromDate,
                        toDate: TeG.Reports.requestData.toDate,
                        currencyId: kendoData.CurrencyId,
                        memberId: kendoData.MemberId
                    };
                    $.ajax({
                        url: tegUrlHelper.progressiveGamePlayPCA,
                        type: "POST",
                        kendoData: kendoData,
                        data: JSON.stringify(sendData),
                        dataType: 'html',
                        contentType: "application/json; charset=utf-8",
                        error: function (jqXHR) {
                            TeG.Popups2.closeTotalHover();
                            tegErrorHandler.processError(jqXHR);
                        }
                    }).done(function (data_html) {
                        var model = {
                            firstAndLastName: this.kendoData.Name,
                            datePeriod: TeG.Reports.requestData.fromDate.replace(/(\d{4})-(\d{2})-(\d{2}).*/, '$3-$2-$1') + ' - '
                                             + TeG.Reports.requestData.toDate.replace(/(\d{4})-(\d{2})-(\d{2}).*/, '$3-$2-$1')
                        };
                        var pcaPopup = new TeG.Popups2.PCA();

                        pcaPopup.placeGrid(data_html);

                        var gridId = $(data_html).find('.k-grid').attr('id');
                        var grid = $('#' + gridId).data('kendoGrid');
                        TeG.Grid.Options.Restore(grid);
                        grid.dataSource.fetch().then(function () {
                            pcaPopup.setModel(model);
                            pcaPopup.show();
                        });
                    });
                }
            };
        },
        //#endregion

        //#region Commission
        Commission: function () {
            return {
                Show: function (type) {
                    $('#searchReport').on('click', { type: type }, function (event) {
                        $("#GlobalSearchEdit").off();
                        $('#cancelSearch').off();
                        var data = {
                            fromDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="fromDate"]').val(), "00", "00"),
                            toDate: TeG.Utils().convertReportDateTime($('#reportHeaderContainer').find('input[name="toDate"]').val(), "23", "59", '59.997'),
                            groupingType: $('#reportHeaderContainer').find('select[name="groupingType"]').val()
                        };

                        ko.cleanNode($('#reportGrids')[0]);
                        ko.applyBindings({ 'groupingType': data.groupingType }, $('#reportGrids')[0]);

                        if (!TeG.Reports().Common().ValidateData()) return;
                        var type = event.data.type;
                        $('#reportData').hide();
                        $('#reportSummaryData').html('');
                        $('#reportSummaryData1').html('');
                        $('#reportGrid1Data').html('');
                        $('#reportSummaryData2').html('');
                        $('#reportSummaryDataMultiCurrency').hide();
                        $('#reportGrid2Data').html('');
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');
                        subordinatesList = null; // global variable used in receiving commision calculation
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array();
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            });
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                }
                            }
                            subordinatesList = data.entityDelimitedList;
                            var getSummaryFunction = function () { };
                            if (type && type == TeG.Reports().Type.MASTER_AGENT) {
                                var getSummaryFunction = TeG.Reports().GetReportSummaryData;
                            } else {
                                var getSummaryFunction = TeG.Reports().GetReportSummaryDataMultiCurrency;
                            }

                            var fromDatePickerOptions = $('#fromDate').data('kendoDatePicker').options;
                            var toDatePickerOptions = $('#toDate').data('kendoDatePicker').options;

                            var fromDateVal = new Date($('#fromDate').data('kendoDatePicker').value());
                            var toDateVal = new Date($('#toDate').data('kendoDatePicker').value());

                            TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.commissionGrid1, $('#reportGrid1Data')
                                , function () {
                                    var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                    data.reportParametersHashCode = reportParametersHashCode;
                                    TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.commissionGrid2, $('#reportGrid2Data')
                                        , function () {
                                            getSummaryFunction(tegUrlHelper.commissionSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode, $('#reportSummaryData1'));
                                            //TeG.Reports().Show();
                                            //TeG.Reports().Commission().Show(type);
                                            //TeG.Reports().EnableToolBar();
                                            //TeG.Utils().customSelectBehaivor(); new TeG.Widget.Element.Multiselect($('#select-subordinates'));

                                            $("#fromDate").kendoDatePicker({
                                                format: fromDatePickerOptions.format,
                                                value: fromDateVal
                                            });
                                            $("#toDate").kendoDatePicker({
                                                format: toDatePickerOptions.format,
                                                value: toDateVal
                                            });

                                            $('#toDate').on('change', function () {
                                                $('#toDate').on('change', function () {
                                                    if ((new TeG.Validator()).IsContainerHasDisplayedErrorMessage($('#fromDate').parent())) {
                                                        TeG.Reports().Common().ValidateData();
                                                    }
                                                });
                                            });

                                            $('.k-widget.k-datepicker.k-header').each(function () {
                                                $(this).attr('style', '');
                                            });

                                            TeG.Reports().Show();
                                            TeG.Reports().Commission().Show(type);
                                            TeG.Reports().EnableToolBar();
                                            TeG.Utils().customSelectBehaivor(); new TeG.Widget.Element.Multiselect($('#select-subordinates'));
                                        }
                                    );
                                }
                           );

                            //$.post(tegUrlHelper.commissionGrid1, JSON.stringify(data), function(html_data) {

                            //    var grid = null;
                            //    var gridId = $(html_data).find('.k-grid').attr('id');
                            //    $('#reportGrid1Data').html(html_data);
                            //    grid = $('div#' + gridId).data('kendoGrid');

                            //    TeG.Grid.Options.Restore(grid);

                            //    grid.dataSource.read().then(function () {
                            //        var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                            //        data.reportParametersHashCode = reportParametersHashCode;

                            //        $.post(tegUrlHelper.commissionGrid2, JSON.stringify({ reportParametersHashCode: reportParametersHashCode }), function (html_data) {
                            //            gridId = $(html_data).find('.k-grid').attr('id');
                            //            $('#reportGrid1Data').html(html_data);
                            //            grid = $('div#' + gridId).data('kendoGrid');
                            //            TeG.Grid.Options.Restore(grid);

                            //            grid.dataSource.read().then(function() {
                            //                getSummaryFunction(tegUrlHelper.commissionSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode, $('#reportSummaryData1'));
                            //                TeG.Reports().Show();
                            //                TeG.Reports().Commission().Show(type);
                            //                TeG.Reports().EnableToolBar();
                            //                TeG.Utils().customSelectBehaivor(); new TeG.Widget.Element.Multiselect($('#select-subordinates'));
                            //            });
                            //        }, "application/json; charset=utf-8");
                            //    });
                            //});

                        } else {
                            //                            var getSummaryFunction = TeG.Reports().GetReportSummaryData
                            TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.commissionGrid1, $('#reportGrid1Data'),
                                function () {
                                    var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                    TeG.Reports().GetReportSummaryData(tegUrlHelper.commissionSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode, $('#reportSummaryData1'));

                                });
                        }
                        (function gridAndSummaryReady() {
                            var reportGridData = $('#reportGrid1Data').html() != '';
                            if ($('#select-subordinates').index() != -1) {
                                reportGridData = (reportGridData && $('#reportGrid2Data').html() != '');
                            }
                            if (reportGridData && ($('#reportSummaryData1').index() != -1 && $('#reportSummaryData1').html() != '')
                                || ($('#reportSummaryData').index() != -1 && $('#reportSummaryData').html() != '')) {
                                if (($('#reportSummaryData1').index() != -1 && $('#reportSummaryData1').html() == '<div></div>')
                                    || ($('#reportSummaryData').index() != -1 && $('#reportSummaryData').html() == '<div></div>') /*HO level*/) { // receive empty summary
                                    $('#reportDataTitleNoData').show();
                                    $('#reportDataTitleSummary').hide();
                                    $('#reportInterval').html('');
                                    $('#reportData > section > div > div').hide();
                                    $('#reportData').show();
                                    $('#reportDataTitle').show();
                                    TeG.Reports().DisableToolBar();
                                } else { // receive summary data
                                    $('#reportDataTitleNoData').hide();
                                    $('#reportInterval').html($('#fromDate').val() + ' - ' + $('#toDate').val());
                                    $('#reportDataTitleSummary').show();
                                    $('#reportSummaryDataMultiCurrency').show() // MultiCurrency level
                                    $('#reportData > section > div > div').show();
                                    $('#reportData').show();
                                }
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                splitterResize();
                            } else {
                                setTimeout(gridAndSummaryReady, 100);
                            }
                        })();
                    });
                },
                ShowCalculation: function (elem) {

                    var reportParametersHashCode;

                    function showCommissionCalculation() {
                        if ($('#isCommissionCalculationSummaryDataGet').html() != 'Yes' || $('#isCommissionCalculationReportDataGet').html() != 'Yes') {
                            setTimeout(showCommissionCalculation, 250);
                            return;
                        } else {
                            tegPopups.totalHoverRemoveDaisyWheel();
                            $('#commissionCalculation').show();
                            $('#commissionCalculationPrint').focus();
                            var comissionCalculationWidth = ($('.commissionCalculationData').width() > $('.commissionCalculationTotalInfo > div').width())
                                ? $('.commissionCalculationData').width()
                                : $('.commissionCalculationTotalInfo > div').width();

                            comissionCalculationWidth = (comissionCalculationWidth > $('#commisionCalculationFooter>span').width())
                                ? comissionCalculationWidth
                                : $('#commisionCalculationFooter>span').width();
                            $('.commissionCalculationData').css('width', '100%');
                            $('.comissionCalculation').width(comissionCalculationWidth).css('margin-left', '-' + Math.round($('.comissionCalculation').width() / 2) + 'px');
                            $('#commissionCalculationPrint').off();
                            $('#commissionCalculationPrint').on('click', function () {
                                window.open(tegUrlHelper.printCommissionCalculationReport);
                            });
                            $('#commissionCalculationExportToExcel').off();
                            $('#commissionCalculationExportToExcel').on('click', function () {
                                window.open(tegUrlHelper.ExportToExcelCommissionCalculationReport + '?reportParametersHashCode=' + reportParametersHashCode + "&rnd=" + new Date().getTime(), "exportToExcel", "_blank,width=450,height=150,centerscreen,alwaysLowered");
                            });
                            $('#commissionCalculationCancel').off();
                            $('#commissionCalculationCancel').on('click', function () {
                                $('#isCommissionCalculationSummaryDataGet').html('No');
                                $('#isCommissionCalculationReportDataGet').html('No');
                                $('.commissionCalculationData').css('width', 'auto');
                                $('#commissionCalculation').width(1200);
                                $('#commissionCalculation').hide();
                                tegPopups.closeTotalHover();
                            });
                        }
                    }
                    tegPopups.showDaisyWheelTotalHover();
                    setTimeout(showCommissionCalculation, 250);
                    var gridId;
                    if ($('#ReportCommissionGrid1Grid').find(elem).index() != -1) {
                        var gridId = 'ReportCommissionGrid1Grid';
                    } else {
                        var gridId = 'ReportCommissionGrid2Grid';
                        subordinatesList = null;  // unsetting entityDelimitedList for specific subordinates
                    }
                    var kendoGrid = $('#' + gridId).data('kendoGrid');
                    var rowIndex = $(elem).closest("tr")[0].rowIndex;
                    var rowData = kendoGrid.dataSource.data()[rowIndex];
                    sendData = $.extend(true, {}, rowData);
                    var fromDateColumnNumber = $('#' + gridId).find('[data-field="FromDate"]').index();
                    var fromDate = kendo.format(kendoGrid.columns[fromDateColumnNumber].format, rowData.FromDate);
                    sendData.FromDate = TeG.Utils().convertReportDateTime(fromDate, 0, 0, 0);
                    var toDateColumnNumber = $('#' + gridId).find('[data-field="ToDate"]').index();
                    var toDate = kendo.format(kendoGrid.columns[toDateColumnNumber].format, rowData.ToDate);
                    sendData.ToDate = TeG.Utils().convertReportDateTime(toDate, 23, 59, 59.999);
                    sendData.entityDelimitedList = subordinatesList;
                    $.ajax({
                        url: tegUrlHelper.commissionCalculation,
                        type: "POST",
                        data: JSON.stringify(sendData),
                        contentType: "application/json; charset=utf-8",
                        error: function (jqXHR) {
                            tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                            tegErrorHandler.processError(jqXHR);
                        }
                    }).done(function (data) {
                        if (data.IsSucceed) {
                            reportParametersHashCode = data.ReportParametersHashCode;

                            $.ajax({
                                url: tegUrlHelper.commissionCalculationSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode,
                                type: "POST",
                                data: JSON.stringify(sendData),
                                contentType: "application/json; charset=utf-8",
                                error: function (jqXHR) {
                                    tegPopups.closeTotalHover();
                                    $('#searchReport').removeClass('loading').blur();
                                    tegErrorHandler.processError(jqXHR);
                                }
                            }).done(function (data) {
                                if (data.IsSucceed) {
                                    var summaryData = data.Data[0];
                                    localStorage.setItem("commissionCalculationSummaryData", JSON.stringify(summaryData));
                                    $('#commissionCalculationAgent').text(summaryData.Name + ' (' + summaryData.LoginName + ')');
                                    $('#commissionCalculationTotal').text(summaryData.TotalCommission);
                                    $('#commissionCalculationCurrency').text(summaryData.Currency);
                                    $('#commissionCalculationTableInfo').html(summaryData.CommissionType);
                                    $('#isCommissionCalculationSummaryDataGet').html('Yes');
                                } else {
                                    tegPopups.errorSucceed();
                                }
                            });

                            $.ajax({
                                url: tegUrlHelper.commissionCalculationGrid1Read + '?reportParametersHashCode=' + reportParametersHashCode,
                                type: "POST",
                                data: JSON.stringify(sendData),
                                contentType: "application/json; charset=utf-8",
                                error: function (jqXHR) {
                                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                    tegErrorHandler.processError(jqXHR);
                                }
                            }).done(function (data) {
                                if (data.IsSucceed) {
                                    var headerTable = '<tr>';
                                    var contentTable = '';
                                    var dataFields = new Array();
                                    for (var key in data.MetaData) {
                                        if (data.MetaData[key].IsVisible) {
                                            headerTable += '<th>' + data.MetaData[key].Caption + '</th>';
                                            dataFields.push(data.MetaData[key].Name);
                                        }
                                    }
                                    for (var i in data.Data) {
                                        contentTable += '<tr>';
                                        for (var j in dataFields) {
                                            contentTable += '<td style=\'text-align: right\'>' + data.Data[i][dataFields[j]] + '</td>';
                                        }
                                        contentTable += '</tr>';
                                    }
                                    headerTable += '<tr>';
                                    $('#commissionCalculationData tbody').html('');
                                    $('#commissionCalculationData tbody').append(headerTable);
                                    $('#commissionCalculationData tbody').append(contentTable);
                                    $('#isCommissionCalculationReportDataGet').html('Yes');
                                    localStorage.setItem("commissionCalculationTableContent", JSON.stringify(headerTable + contentTable));
                                } else {
                                    tegPopups.errorSucceed();
                                }
                            });

                        } else {
                            tegPopups.errorSucceed();
                        }
                    });
                },

                DataBound1: function (event) {
                    //restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBound(event);
                    $('.commissionAmountPopup').on('click', function (event) {
                        TeG.Reports().Commission().ShowCalculation(this);
                    });
                    TeG.Reports().EnableToolBar();
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', function () {
                        var printReport = new TeG.Print('divReportCommissionGrid1Grid');
                        printReport.Storage().StorageReportTitle('Commission', null, $('#reportSummaryData1')).Open(tegUrlHelper.commissionReport);
                    });
                    splitterResize();
                },

                DataBound1HO: function (event) {
                    //restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBound(event);
                    $('.commissionAmountPopup');
                    $('.commissionAmountPopup').off();
                    $('.commissionAmountPopup').on('click', function (event) {
                        TeG.Reports().Commission().ShowCalculation(this);
                    });
                    $('#reportGrid1Data').find('.k-widget.k-grid').addClass('no-resize');
                    $('#reportGrid1Data').find('.k-grid-header').addClass('no-resize').css('padding-right', '0px');
                    $('#reportGrid1Data').find('.k-grid-content').addClass('no-resize').css('height', '100%');
                    var printModel = { fromDate: ko.observable('09-09-2008'), toDate: ko.observable('01-09-2010') }
                    ko.cleanNode($('#reportHeaderContainer').get(0));
                    ko.applyBindings(printModel, $('#reportHeaderContainer').get(0));
                    TeG.Reports().EnableToolBar();
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportCommissionGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('My Commission');
                        gridPrint.store();
                        gridPrint.setGrid($('#ReportCommissionGrid2Grid').data('kendoGrid'));
                        gridPrint.setTitle('Master Agent Commission');
                        gridPrint.storeAdd();
                        gridPrint.openReport();
                    });
                    splitterResize();
                },

                DataBound2HO: function (event) {
                    //restoreColumnsWidthes(event);
                    $('.commissionAmountPopup').off();
                    $('.commissionAmountPopup').on('click', function (event) {
                        TeG.Reports().Commission().ShowCalculation(this);
                    });
                    $('#reportData').css('overflow-y', 'auto').css('overflow-x', 'hidden');
                    (new TeG.Grid(event.sender)).markFilter(); // looks like a trick, because I'm not shure that event.sender == grid (like polymorf in this case)
                    splitterResize();
                }
            }
        },
        //#endregion

        //#region Cashier
        Cashier: function () {
            return {
                Show: function (type) {
                    $('select[name="groupingType"]').off();
                    $('select[name="groupingType"]').on('change', function () {
                        if (type && type == 'HO' && $('select[name="groupingType"]').val() == 'Daily') {
                            $('#currency-type').val($('#currency-type option[value="0"]').next().attr('value'));
                            $('#currency-type option[value="0"]').hide();
                        } else {
                            $('#currency-type option[value="0"]').show();
                        }
                    });
                    if (localStorage.getItem('cashierReport')) {
                        $(function () {
                            var storage = JSON.parse(localStorage.getItem('cashierReport'));
                            storage.fromDate && $('input#fromDate').val(storage.fromDate);
                            storage.toDate && $('input#toDate').val(storage.toDate);
                            storage.groupingType && $('select[name="groupingType"]').val(storage.groupingType);
                            if (storage.groupingType == 'Detailed') {
                                $('.nDailyTime').hide();
                                $('.time').show();
                            }
                            localStorage.removeItem('cashierReport');
                            (function _clickSearch() {
                                if ($('#loginCurrencyId').val() != '') {
                                    $('#searchReport').click();
                                } else {
                                    setTimeout(_clickSearch, 200)
                                }
                            }());
                        });
                    }
                    if (type && type == 'cashier') {
                        function _switchDateTime() {
                            if ($('select[name="groupingType"]').val() == 'Detailed') {
                                $('.time').show();
                                $('.nDailyTime').hide();
                            } else {
                                $('.time').hide();
                                $('.nDailyTime').show();
                            }
                        }
                        _switchDateTime();
                        $('select[name="groupingType"]').on('change', _switchDateTime);
                    }
                    $('#searchReport').on('click', function () {
                        TeG.Reports().Common().StartSearch();
                        var fromHour = ($('select[name="fromDateHour"]').is(':visible')) ? $('select[name="fromDateHour"]').val() : '00';
                        var toHour = ($('select[name="toDateHour"]').is(':visible')) ? $('select[name="toDateHour"]').val() : '23';
                        var fromMinute = ($('select[name="fromDateMinute"]').is(':visible')) ? $('select[name="fromDateMinute"]').val() : '00';
                        var toMinute = ($('select[name="toDateMinute"]').is(':visible')) ? $('select[name="toDateMinute"]').val() : '59';
                        var data = {
                            customerType: ($('input[name="customerType"]').index() != -1) ? $('input[name="customerType"]:checked').val() : 'All',
                            fromDate: TeG.Utils().convertReportDateTime($('input[name="fromDate"]').val(), fromHour, fromMinute),
                            toDate: TeG.Utils().convertReportDateTime($('input[name="toDate"]').val(), toHour, toMinute, '59.997'),
                            groupingType: $('select[name="groupingType"]').val(),
                            timezoneType: $('select[name="timezoneType"]').val()
                        };
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array();
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            });
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    data.entityDelimitedList = '';
                                } else {
                                    data.entityDelimitedList = subordinates.join();
                                }
                            }
                        }
                        if ($('#currency-type').index() != -1) {
                            if ($('#currency-type').val() == 1) {
                                data.currencyId = $('#loginCurrencyId').val();
                            }
                        } else {
                            data.currencyId = $('#loginCurrencyId').val();
                        }
                        if (type && type == 'HO') {
                            data.customerType = 'All';
                            var getSummaryData = TeG.Reports().GetReportSummaryDataMultiCurrency2;
                        } else {
                            var getSummaryData = TeG.Reports().GetReportSummaryData2;
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        tegPopups.showTotalHover();
                        $('#reportData').hide();
                        $('#searchReport').addClass('loading');
                        sendData = data; // must be in global scope
                        if (type && type == 'cashier' && data.groupingType == 'Daterange') {
                            searchReportFlow.isDataBound = true;
                            searchReportFlow.isDataEmpty = false;
                            TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.cashierReportsData, $('#reportGridData'),
                                function () {
                                    var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                    TeG.Reports().GetReportSummaryData2(tegUrlHelper.cashierSummaryRead + '?reportParametersHashCode='
                                        + reportParametersHashCode, $('#reportSummaryData'), function () {
                                            $('#reportGridData').hide();
                                        });
                                });
                        } else {
                            TeG.Reports().GetReportData(JSON.stringify(data), tegUrlHelper.cashierReportsData, $('#reportGridData'),
                                function () {
                                    var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                    getSummaryData(tegUrlHelper.cashierSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode
                                        , $('#reportSummaryData'));
                                });
                        }
                    });
                },

                DataBound: function (event, type) {
                    // restoreColumnsWidthes(event);
                    if (!((type == 'cashier') && (sendData.groupingType == 'Daterange'))) {
                        TeG.Reports().Common().DataBound(event);
                    }
                    if (type == 'cashier') {
                        if (sendData.groupingType == 'Account') {
                            $('.customer-type').each(function () {
                                var key = $(this).closest('tr').prevAll().length;
                                var val = $(this).html();
                                val = val.replace(/Player/, "<img src='/Images/icPlayer.png' title='Player'>");
                                val = val.replace(/Station/, "<img src='/Images/icStation.png' title='Station'>");
                                $('#ReportCashierGrid1Grid').data('kendoGrid').dataSource._data[key].CustomerType = val;
                                $(this).html(val);
                            });
                        }
                        if (sendData.groupingType == 'Daily') {
                            $('.js-date').each(function () {
                                $(this).removeClass('.js-date').addClass('cashier-report-date');
                                $(this).on('click', function () {
                                    var storage_data = {
                                        fromDate: $(this).html(),
                                        toDate: $(this).html(),
                                        groupingType: 'Detailed'
                                    }
                                    localStorage.setItem('cashierReport', JSON.stringify(storage_data));
                                    window.open(window.location.href, '_blank');
                                });
                            });
                        }
                        if (sendData.groupingType == 'Detailed') {
                            $('.customer-type').each(function () {
                                var key = $(this).closest('tr').prevAll().length;
                                var val = $(this).html();
                                val = val.replace(/Player/, "<img src='/Images/icPlayer.png' title='Player'>");
                                val = val.replace(/Station/, "<img src='/Images/icStation.png' title='Station'>");
                                $('#ReportCashierGrid1Grid').data('kendoGrid').dataSource._data[key].CustomerType = val;
                                $(this).html(val);
                            });
                            $('.receiptNumber').on('click', function (event) {
                                TeG.Popups().receipt().get($.trim($(this).html())).show();
                            });
                        }
                        if (sendData.groupingType == 'Daterange') {
                            $('#reportGridData').hide();
                            $('#linkPrint').off();
                            $('#linkPrint').on('click', { that: this }, function (event) {
                                TeG.Reports().StoreTitle();
                                TeG.Reports().StoreSummary();
                                var gridPrint = new (TeG.Print()).PrintGrid();
                                gridPrint.setTitle('Cashier');
                                gridPrint.store();
                                gridPrint.openReport();
                            });
                            return;
                        }
                    }
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        if (!($('select[name="groupingType"]').val() == 'Daterange' && $('#select-subordinates').index() == -1)) {
                            gridPrint.setGrid($('#ReportCashierGrid1Grid').data('kendoGrid'));
                        }
                        gridPrint.setTitle('Cashier');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region GrossWinAnalysis
        GrossWinAnalysis: function () {
            return {
                Show: function (type) {
                    TeG.Reports.type = type;
                    (function _setHeadOfficeCurrency() {
                        if (!$('#currency').text()) {
                            setTimeout(_setHeadOfficeCurrency, 100)
                        }
                        $('#head-office-currency').text($('#currency').text());
                    }());

                    function _getDate(val) {
                        var match = val.match(/\d{2,4}/g);
                        return new Date(match[2], match[1] - 1, match[0]);
                    }

                    $('select[name="groupingType"]').on('change', { that: this }, function (event) {
                        if ($(this).val() === 'MasterAgent') {
                            $('#head-office-currency-choice').hide();
                            $('#multi-currency-choice').show();
                        } else {
                            $('#head-office-currency-choice').show();
                            $('#multi-currency-choice').hide();
                        }
                    });
                    $('#searchReport').on('click', { that: this }, function (event) {
                        $('#reportData').hide();
                        if ($('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid')) {
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').destroy();
                            $('#reportGridData').html('');
                        }

                        if ((new TeG.Validator()).IsContainerHasDisplayedErrorMessage($('#report'))) return false;

                        // date validation 62 days
                        (new TeG.Validator()).CleanError($('#fromDate')); // clear error message
                        (new TeG.Validator()).CleanError($('#toDate')); // clear error message
                        function _getDate(val) {
                            var match = val.match(/\d{2,4}/g)
                            if (match.length == 3) {
                                return new Date(match[2], match[1] - 1, match[0]);
                            } else if (match.length == 2) {
                                return new Date(match[2], match[1] - 1, 1);
                            }
                        }
                        if ($('[name="timeGrouping"]:checked').val() == 'Day') {
                            if (_getDate($('#fromDate').val()).setDate(_getDate($('#fromDate').val()).getDate() + 62) < _getDate($('#toDate').val())) {
                                new TeG.Validator($('#toDate')).SetMessage(TeG.Translations.ValidateInsertFieldInCorrectFormat
                                    .replace(/%%field_label%%/, $('label[for="toDate"]').html().replace(/^\s*|\:|\s*$/g, '')))
                                    .DisplayErrorMessageOffsetTop(3).ErrorRenderDefault();
                                return;
                            }
                        }
                        var that = event.data.that;
                        TeG.Reports().Common().StartSearch();
                        var dataSend = {};
                        dataSend.timeGrouping = $('input[name="timeGrouping"]:checked').val();
                        if (dataSend.timeGrouping == 'Month') {
                            dataSend.fromDate = TeG.Utils().convertReportDateTime('01-' + $('input[name="fromDate"]').val(), '00', '00');
                            var toDateVal = $('input[name="toDate"]').val().split('-') // new Date('1999', '03', 0).getDate()
                            dataSend.toDate = TeG.Utils().convertReportDateTime(new Date(toDateVal[1], toDateVal[0], 0).getDate() + '-' + $('input[name="toDate"]').val(), '23', '59', '59.997');
                        } else {
                            dataSend.fromDate = TeG.Utils().convertReportDateTime($('input[name="fromDate"]').val(), '00', '00');
                            dataSend.toDate = TeG.Utils().convertReportDateTime($('input[name="toDate"]').val(), '23', '59', '59.997')
                        }
                        dataSend.groupingType = $('select[name="groupingType"]').val();
                        if ($('#select-subordinates').index() != -1) {
                            var subordinates = new Array()
                            $('#select-subordinates > div.selected').each(function () {
                                subordinates.push($(this).attr('data-value'));
                            })
                            if (subordinates.length > 0) {
                                if (subordinates[0] == 'All') {
                                    dataSend.entityDelimitedList = '';
                                } else {
                                    dataSend.entityDelimitedList = subordinates.join();
                                }
                            }
                        }
                        if ($('select[name="gameClientType"]').is(':visible')) {
                            dataSend.gameClientType = $('select[name="gameClientType"]').val();
                        } else {
                            dataSend.gameClientType = 'All';
                        }
                        if ($('#head-office-currency-choice').length > 0) {
                            if ($('#head-office-currency-choice').is(':visible')) {
                                dataSend.currencyId = $('#loginCurrencyId').val();
                            } else {
                                dataSend.currencyId = $('#currency-type').val();
                                if (dataSend.currencyId == 1) {
                                    dataSend.currencyId = $('#loginCurrencyId').val();
                                }
                            }
                        } else {
                            dataSend.currencyId = $('#loginCurrencyId').val();
                        }
                        dataSend.gameTypeId = $('input[name="gameTypeId"]:checked').val();
                        if (type && type == 'HO') {
                            var summaryMethod = TeG.Reports().GetReportSummaryDataMultiCurrency2;
                        } else {
                            var summaryMethod = TeG.Reports().GetReportSummaryData2;
                        }
                        if (!TeG.Reports().Common().ValidateData()) return;
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');
                        searchRequest = dataSend //global
                        TeG.Reports().GetReportData(JSON.stringify(dataSend), tegUrlHelper.grossWinAnalysis, $('#reportGridData'),
                            function () {
                                var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                                summaryMethod(tegUrlHelper.grossWinAnalysisSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode);
                            });
                    });
                    if (TeG.Reports.type && TeG.Reports.type == 'HO') {
                        var imageDetail = '<img src="/Images/icMasterAgent.png" style="margin-left:25px; width:15px; height:15px;">&nbsp;';
                    } else {
                        var imageDetail = '<img src="/Images/icAgent.png" style="margin-left:25px; width:15px; height:15px;">&nbsp;';
                    }
                    var imageDetailRegex = new RegExp(imageDetail);

                    /**
                     * Receive expanded data
                     * @param category - game category
                     * @param hash - report hash code
                     * @param that - pointer to clicked row
                     * @param event - event
                     * @param next - callback
                     * @private
                     */
                    function _getInsertData(category, agent, hash, that, event, next) {
                        TeG.Popups2.showDaisyWheelTotalHover();
                        $.ajax({
                            url: tegUrlHelper.casinoGrossWinAnalysisGrid1AggregatedDataRead,
                            type: "POST",
                            that: that,
                            event: event,
                            data: JSON.stringify({ reportParametersHashCode: hash, gameCategory: category, agentName: agent }),
                            contentType: "application/json; charset=utf-8",
                            error: function (jqXHR) {
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                tegErrorHandler.processError(jqXHR, TeG.Translations.PopupError);
                            }
                        }).done(function (data) {
                            var that = this.that;
                            if (typeof (next) == 'function') next(data, that, event);
                        });
                    }
                    $(document).on('click', '#ReportCasinoGrossWinAnalysisGrid1Grid tr', { that: this }, function (event) {
                        if ((imageDetailRegex).test($(this).find('td').eq(0).html())) {
                            return;
                        }
                        if (searchRequest.groupingType != 'GameCategory' && searchRequest.groupingType != 'MasterAgent' && searchRequest.groupingType != 'Agent') {
                            return;
                        }
                        var imageCollapseRegex = new RegExp(event.data.that.getImageGroupCollapse());
                        var imageExpandRegex = new RegExp(event.data.that.getImageGroupExpand());
                        var index = event.data.that.index = $(this).prevAll().length;
                        var currentData = event.data.that.currentData = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.at(index);
                        event.data.that.uid = $(this).attr('data-uid');
                        if (searchRequest.groupingType == 'GameCategory') {
                            var category = (TeG.Reports.type && TeG.Reports.type == 'HO') ? 'GameCategoryMasterAgent' : 'GameCategoryAgent';
                        }
                        else if(searchRequest.groupingType == 'MasterAgent' || searchRequest.groupingType == 'Agent') {
                            var category = (TeG.Reports.type && TeG.Reports.type == 'HO') ? 'MasterAgentGameClientType' : 'AgentGameClientType';
                        }

                        var _highlight = function () {
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').find('tr').find('td[role="gridcell"] > .arrow-down').parents('tr').addClass('bold blue-top-tr');
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').find('tr').find('td[role="gridcell"] > img')
                                .parents('tr').addClass('blue-tr')
                                .next(":not(.blue-tr, .blue-top-tr)").prev().addClass('blue-bottom-tr');
                        };
                        var dsChangeEvents = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._events.change;
                        var isHightlightPresent = false;
                        for (i = 0; i < dsChangeEvents.length; i++) {
                            if (dsChangeEvents[i].toString() === _highlight.toString()) {
                                isHightlightPresent = true;
                            }
                        }
                        if (!isHightlightPresent) {
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._events.change.push(_highlight);
                        }

                        if (imageCollapseRegex.test($(this).find('td').eq(0).html())) {
                            var gameCategory = (searchRequest.groupingType == 'GameCategory') ? currentData.GameCategory : null;
                            var agentName = null;
                            if (searchRequest.groupingType == 'MasterAgent') {
                                agentName = currentData.MasterAgent;
                            }
                            else if (searchRequest.groupingType == 'Agent') {
                                agentName = currentData.Agent;
                            }
                            _getInsertData(gameCategory, agentName, getReportParametersHashCode().reportParametersHashCode, this, event, function (data, that, event) {
                                var totalFunction = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total;
                                var totalRecords = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total();
                                var currentData = event.data.that.currentData;
                                var index = event.data.that.index;
                                currentData[category] = currentData[category].replace(imageCollapseRegex, event.data.that.getImageGroupExpand());
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.remove(currentData);
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.insert(index, currentData);
                                var insertData = data.Data;
                                index++;
                                var kendoData = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._data;
                                for (var key = 0; key < insertData.length; key++) {
                                    if (searchRequest.groupingType == 'MasterAgent' || searchRequest.groupingType == 'Agent') {
                                        insertData[key][category] = '<img src="/Images/pixel.png" style="margin-left:25px; width:1px; height:1px;">&nbsp;' + insertData[key][category];
                                    }
                                    else {
                                        insertData[key][category] = imageDetail + insertData[key][category];
                                    }
                                }
                                var kendoDataBeforeInsert = kendoData.splice(0, index);
                                var kendoDataAfterInsert = kendoData.splice(0, kendoData.length);
                                var newKendoData = kendoDataBeforeInsert.concat(insertData, kendoDataAfterInsert);
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.data(newKendoData);
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                                $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;
                                TeG.Popups().closeTotalHover();
                            });
                        } else if (imageExpandRegex.test($(this).find('td').eq(0).html())) {
                            var totalFunction = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total;
                            var totalRecords = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total();
                            currentData[category] = currentData[category].replace(imageExpandRegex, event.data.that.getImageGroupCollapse());
                            index++;
                            var kendoData = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._data;
                            var startIndex = index;
                            while (typeof (kendoData[index]) != 'undefined' && /img/.test(kendoData[index][category])) {
                                index++;
                            }
                            var endIndex = index;
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                            kendoData.splice(startIndex, endIndex - startIndex);
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                            $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;

                        }
                        $('.k-grid-content').eq(0).scrollTo($('[data-uid="' + event.data.that.uid + '"]'), 750);
                    });
                },

                DataBinding: function (event) {
                    if (event.action == 'remove' || event.action == 'add') {
                        window.isSearchClicked = false;
                    }
                },

                DataBound: function (event) {
                    //restoreColumnsWidthes(event);

                    if (searchRequest.groupingType == 'GameCategory' || searchRequest.groupingType == 'MasterAgent' || searchRequest.groupingType == 'Agent') {
                        var imageGroupCollapse = this.getImageGroupCollapse();
                        var imgRegexCollapse = new RegExp(imageGroupCollapse);
                        var imageGroupExpand = this.getImageGroupExpand();
                        var imageRegexExpand = new RegExp(imageGroupExpand);
                        var kendoData = $('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid').dataSource._data;
                        if (searchRequest.groupingType == 'GameCategory') {
                            var category = (TeG.Reports.type && TeG.Reports.type == 'HO') ? 'GameCategoryMasterAgent' : 'GameCategoryAgent';
                        }
                        else if (searchRequest.groupingType == 'MasterAgent' || searchRequest.groupingType == 'Agent') {
                            var category = (TeG.Reports.type && TeG.Reports.type == 'HO') ? 'MasterAgentGameClientType' : 'AgentGameClientType';
                        }
                        for (var i = 0; i < kendoData.length; i++) {
                            if (!imageRegexExpand.test(kendoData[i][category]) && !imgRegexCollapse.test(kendoData[i][category]) && !/img/.test(kendoData[i][category])) {
                                kendoData[i][category] = imageGroupCollapse + kendoData[i][category];
                            }
                        }
                        $('#ReportCasinoGrossWinAnalysisGrid1Grid .k-grid-content tr').each(function () {
                            if (!imageRegexExpand.test($(this).find('td').eq(0).html()) && !imgRegexCollapse.test($(this).find('td').eq(0).html()) && !/img/.test($(this).find('td').eq(0).html())) {
                                $(this).find('td').eq(0).html(imageGroupCollapse + $(this).find('td').eq(0).html());
                            }
                        });
                    }
                    TeG.Reports().Common().DataBound(event);
                    // collapse expand Search Criteria
                    if (event.sender._data.length > 10 && $('#collapseBehaivor').is(':visible')) {
                        TeG.Reports().Common().ExpandCollapse();
                    }
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportCasinoGrossWinAnalysisGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Gross Win Analysis');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                    splitterResize();
                },

                ColumnReorder: function (event) {
                    if (event.newIndex == 0 || event.oldIndex == 0/* && typeof(TeG.ReportReorderColumn) == 'undefined'*/) {
                        setTimeout(function () {
                            event.sender.reorderColumn(event.oldIndex, event.sender.columns[event.newIndex]);
                        }, 100);
                    }
                    else {
                        TeG.Grid.Options.Store(event);
                    }
                },

                columnShow: function (event) {
                    setTimeout(function () {
                        $('input[type="checkbox"][data-field="GameCategoryMasterAgent"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="GameCategoryAgent"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="MasterAgentGameClientType"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="AgentGameClientType"]').attr('disabled', 'disabled');
                    });
                },

                ColumnHide: function (event) {
                    setTimeout(function () {
                        $('input[type="checkbox"][data-field="GameCategoryMasterAgent"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="GameCategoryAgent"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="MasterAgentGameClientType"]').attr('disabled', 'disabled');
                        $('input[type="checkbox"][data-field="AgentGameClientType"]').attr('disabled', 'disabled');
                    });
                    if (event.column.field == 'GameCategoryMasterAgent' || event.column.field == 'GameCategoryAgent' ||
                        event.column.field == 'MasterAgentGameClientType' || event.column.field == 'AgentGameClientType') {
                        event.sender.showColumn(0);
                    }
                },

                ColumnMenuInit: function (event) {
                    $('input[type="checkbox"][data-field="GameCategoryMasterAgent"]').attr('disabled', 'disabled');
                    $('input[type="checkbox"][data-field="GameCategoryAgent"]').attr('disabled', 'disabled');
                    $('input[type="checkbox"][data-field="MasterAgentGameClientType"]').attr('disabled', 'disabled');
                    $('input[type="checkbox"][data-field="AgentGameClientType"]').attr('disabled', 'disabled');
                },

                getImageGroupCollapse: function () {
                    return '<div class="arrow-right"></div>&nbsp;';
                },

                getImageGroupExpand: function () {
                    return '<div class="arrow-down"></div>&nbsp;';
                }
            }
        },
        //#endregion

        //#region PlayCheck
        PlayCheck: function () {
            return {
                Show: function () {
                    $('input[name="headerRadio"]').on('click', { that: this }, function () {
                        if ($(this).val() == 'searchBy') {
                            $('.play-check-half-title1 table input[type="radio"]').removeAttr('disabled');
                            $('#master-agent-block').hide();
                            $('#ma-select-cover').show();
                            if ($('#ordinate-row').index() != -1) {
                                $('#subordinate-row').hide();
                            }
                            $('.play-check-half-title1 table input[type="radio"]:checked').click().click();
                        } else {
                            $('.play-check-half-title1 table input[type="radio"]').attr('disabled', true);
                            $('.play-check-half-title1 table input[type="text"]').val('').focus().attr('disabled', true);
                            $('select#agent').attr('disabled', false);
                            $('#master-agent-block').show();
                            //$('#master-agent').data('kendoDropDownList').select(0);
                            $('#ma-select-cover').hide();
                        }
                    });
                    $('input[name="radioSearchBy"]').on('click', { that: this }, function () {
                        $('.play-check-half-title1 table input[type="text"]').val('').focus().attr('disabled', true);
                        $('.play-check-half-title1 table input[type="text"]').val('');
                        $(this).parent().parent().find('input[type="text"]').removeAttr('disabled').focus();
                    });
                    $('#account-name-check').click();
                    $('#master-agent').on('change', { that: this }, function () {
                        if ($(this).val() == '') {
                            $('#subordinate-row').hide();
                            return;
                        } else {
                            // Clear error message
                            (new TeG.Validator()).CleanAllError($('#select-MA'));
                        }
                        tegPopups.showDaisyWheelTotalHover();
                        $.ajax({
                            url: tegUrlHelper.getSubordinates,
                            type: "POST",
                            data: JSON.stringify({ LoginName: $(this).val() }),
                            contentType: "application/json; charset=utf-8",
                            error: function (jqXHR) {
                                tegPopups.closeTotalHover();
                                tegErrorHandler.processError(jqXHR, TeG.Translations.PopupError);
                            }
                        }).done(function (data) {
                            if (typeof (subordinatesViewModel) == 'undefined') {
                                subordinatesViewModel = {};
                                subordinatesViewModel.subordinates = ko.observableArray(); // must be global
                            }
                            subordinatesViewModel.subordinates.removeAll();
                            subordinatesViewModel.subordinates.push({ FirstName: TeG.Translations.ReportOptionsPleaseSelect, LastName: '', LoginName: '' });
                            for (key in data.SubOrdinates) {
                                subordinatesViewModel.subordinates.push(data.SubOrdinates[key]);
                            }
                            if (!ko.dataFor($('#agent').get(0))) {
                                ko.applyBindings(subordinatesViewModel, $('#agent').get(0));
                            }
                            $('#agent').focus();
                            $('#subordinate-row').show();
                            tegPopups.closeTotalHover();
                        });
                    });
                    $('#agent').on('change', { that: this }, function (event) {
                        if ($(this).val() == '' || $(this).val().trim() == TeG.Translations.ReportOptionsPleaseSelect.trim()) {
                            return;
                        }
                        $('#searchReport').click();
                    });
                    TeG.Reports().PlayCheck().Validate();
                    $('#searchReport').on('click', { that: this }, function (event) {
                        // validate block
                        $('.play-check-half-title1 input[type="text"]').blur();
                        if ($('#master-agent').index() != -1) {
                            if (!$('#master-agent').is(':disabled') && !$('#agent').is(':visible')) {
                                if ($('#master-agent').val() == '') {
                                    (new TeG.Validator($('#master-agent')))
                                        .SetMessage(TeG.Translations.ValidateSelectField
                                            .replace(/%%field_label%%/, $('label[for="master-agent"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                        .ErrorRenderInHtml2();
                                }
                            }
                        }
                        if ($('#agent').is(':visible') && !$('#agent').is(':disabled')) {
                            if ($.trim($('#agent').val()) == '' || $.trim($('#agent').val()) == TeG.Translations.ReportOptionsPleaseSelect) {
                                (new TeG.Validator($('#agent')))
                                    .SetMessage(TeG.Translations.ValidateSelectField
                                        .replace(/%%field_label%%/, $('label[for="agent"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                    .ErrorRenderInHtml2();
                            }
                        }
                        if ((new TeG.Validator()).IsContainerHasDisplayedErrorMessage($('#reportHeaderContainer'))) return;
                        // end validate block
                        TeG.Reports().Common().StartSearch();
                        $('#reportGridData').hide();
                        $('#reportDataTitle').hide();
                        $('#reportDataTitleNoData').hide();
                        searchRequest = { accountNumber: '', playerName: '', phoneNumber: '', loginName: '' }; // global
                        if (!$('#account-name').is(':disabled')) {
                            searchRequest.accountNumber = $('#account-name').val();
                        } else if (!$('#mobile-number').is(':disabled')) {
                            searchRequest.phoneNumber = $('#mobile-number').val();
                        } else if (!$('#player-station-name').is(':disabled')) {
                            searchRequest.playerName = $('#player-station-name').val();
                        } else if ($('#agent').is(':visible')) {
                            searchRequest.loginName = $('#agent').val();
                        }
                        tegPopups.showTotalHover();
                        $('#searchReport').addClass('loading');
                        TeG.Reports().GetReportData(JSON.stringify(searchRequest), tegUrlHelper.playCheckGrid1, $('#reportGridData'), function () { });
                    });
                },

                Validate: function () {
                    $('#account-name').on('blur', function (event) {
                        if (!$('#account-name').is(':disabled')) {
                            (new TeG.Validator($('#account-name')))
                                .PreferredUsernameUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat
                                    .replace(/%%field_label%%/, $('label[for="account-name-check"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                .PreferredUsernameIncorrectWeakListener(TeG.Translations.ValidateInsertFieldInCorrectFormat
                                    .replace(/%%field_label%%/, $('label[for="account-name-check"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                .RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel
                                    .replace(/%%field_label%%/, $('label[for="account-name-check"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                .ErrorRenderInHtml2();
                        }
                    });
                    $('#mobile-number').on('blur', function (event) {
                        if (!$('#mobile-number').is(':disabled')) {
                            (new TeG.Validator($('#mobile-number')))
                                .MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain
                                    .replace(/%%field_label%%/, $('label[for="mobile-number-check"]').html().replace(/\*|\:/g, '')))
                                .MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain
                                    .replace(/%%field_label%%/, $('label[for="mobile-number-check"]').html().replace(/\*|\:/g, '')))
                                .RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel
                                    .replace(/%%field_label%%/, $('label[for="mobile-number-check"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                .ErrorRenderInHtml2();
                        }
                    });
                    $('#player-station-name').on('blur', function (event) {
                        if (!$('#player-station-name').is(':disabled')) {
                            (new TeG.Validator($('#player-station-name')))
                                .PlayerUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat
                                    .replace(/%%field_label%%/, $('label[for="player-station-name-check"]').html().replace(/\*|\:/g, '')))
                                .PlayerIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat
                                    .replace(/%%field_label%%/, $('label[for="player-station-name-check"]').html().replace(/\*|\:/g, '')))
                                .RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel
                                    .replace(/%%field_label%%/, $('label[for="player-station-name-check"]').html().replace(/^s*|\*|\:|\s*$/g, '')))
                                .ErrorRenderInHtml2();
                        }
                    });
                },

                StoreTitle: function (titleData) {
                    if ($('#search-by').is(':checked')) {
                        if ($('#account-name-check').is(':checked')) {
                            titleData.playCheckParameter = { visible: true, label: $('label[for="account-name-check"]').html(), value: $('#account-name').val() }
                        }
                        if ($('#mobile-number-check').is(':checked')) {
                            titleData.playCheckParameter = { visible: true, label: $('label[for="mobile-number-check"]').html(), value: $('#mobile-number').val() }
                        }
                        if ($('#player-station-name-check').is(':checked')) {
                            titleData.playCheckParameter = { visible: true, label: $('label[for="player-station-name-check"]').html(), value: $('#player-station-name').val() }
                        }
                    } else {
                        if ($('#agent option:selected').index() != -1 || $('label[for="agent"]').index() != -1) {
                            titleData.playCheckParameter = { visible: true, label: $('label[for="agent"]').html(), value: $('#agent option:selected').html() }
                        } else {
                            titleData.playCheckParameter = { visible: false, label: '', value: '' }
                        }
                    }
                    if ($('#master-agent').index() != -1 && !$('#master-agent').is(':disabled')) {
                        titleData.playCheckParameterMA = { visible: true, label: $('label[for="master-agent"]').html(), value: $('#master-agent option:selected').html() }
                    } else {
                        titleData.playCheckParameterMA = { visible: false, label: '', value: '' }
                    }
                    return titleData;
                },

                DataBound: function (event) {
                    // Removing cells content from "Status" column.
                    $(event.sender.table).find('td.customerAccountStatus').text('');

                    if (event.sender.dataSource._data.length == 0 && typeof (searchReportFlow) != 'undefined') {
                        $('#reportDataTitle').show();
                        $('#reportDataTitleNoData').show();
                        $('#searchReport').removeClass('loading');
                        tegPopups.closeTotalHover();
                        return;
                    }
                    TeG.Reports().Common().EndSearch();
                    if (typeof (TeG.RreportIsDataBind) === 'undefined') {
                        var kendoData = $('#ReportPlayCheckGrid1Grid').data('kendoGrid').dataSource._data;
                        for (var i = 0; i < kendoData.length; i++) {
                            if (kendoData[i].CustomerType == 'Player') {
                                kendoData[i].CustomerType = "<div style='text-align: center;'><img src='/Images/icPlayer.png'></div>"
                            } else if (kendoData[i].CustomerType == 'Station') {
                                kendoData[i].CustomerType = "<div style='text-align: center;'><img src='/Images/icStation.png'></div>"
                            }
                            kendoData[i].PlayCheckUrl = "<div style='text-align: center;'><a target='_blank' href='" + kendoData[i].PlayCheckUrl
                                + "'><img src='/Images/playcheck.png'></a><div>";
                        }
                        TeG.RreportIsDataBind = true;
                        var total = $('#ReportPlayCheckGrid1Grid').data('kendoGrid').dataSource.total();
                        $('#ReportPlayCheckGrid1Grid').data('kendoGrid').dataSource.data(kendoData);
                        $('#ReportPlayCheckGrid1Grid').data('kendoGrid').dataSource._total = total;
                    } else {
                        delete TeG.RreportIsDataBind;
                    }
                    $('#searchReport').removeClass('loading');
                    tegPopups.closeTotalHover();
                    $('#reportGridData').show();
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle(TeG.Print.REPORT_SUMMARY_NOT_VISIBLE);
                        TeG.Reports().StoreSummary(TeG.Print.REPORT_SUMMARY_DATA_NOT_VISIBLE);
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportPlayCheckGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('PlayCheck');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                    TeG.Reports().EnableToolBar();
                    TeG.Reports.grid1.markFilter();
                    if (event.sender._data.length > 10 && $('#collapseBehaivor').is(':visible') && window.isSearchClicked) {
                        TeG.Reports().Common().ExpandCollapse();
                    } else if (event.sender._data.length <= 10 && $('#expandBehaivor').is(':visible') && window.isSearchClicked) {
                        TeG.Reports().Common().ExpandCollapse();
                    }

                    // Tooltips for status column and headers
                    if ($("[data-role=tooltip]").length > 0 && $("[data-role=tooltip]").data('kendoTooltip')) {
                        $("[data-role=tooltip]").data('kendoTooltip').destroy();
                    }
                    TeG.kendoGridManager();
                    splitterResize();
                }
            }
        },
        //#endregion

        //#region CurrentNetworkBalance
        CurrentNetworkBalance: function () {
            return {
                Show: function () {
                    reportViewModel = currentNetworkBalance;
                    reportViewModel.activate($('#report').get(0));
                    tegPopups.showTotalHover();
                    TeG.Reports().GetReportData(JSON.stringify({}), tegUrlHelper.casinoNetworkBalance, $('#reportGridData'),
                        function () {
                            var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                            TeG.Reports().GetReportSummaryDataKO(tegUrlHelper.casinoNetworkBalanceSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode,
                                function (data) {
                                    // add currency to several field override behavior in summary receive method
                                    var currency = data.Data[0].Currency;
                                    reportViewModel.summary.removeAll();
                                    for (var i = 0; i < data.MetaData.length; i++) {
                                        if (typeof (data.Data[0][data.MetaData[i].Name]) != 'undefined') {
                                            if (["Balance", "Balance in Head Office Currency", "Hierarchy Credits"].indexOf(data.MetaData[i].Caption) != -1) {
                                                reportViewModel.summary.push({
                                                    caption: data.MetaData[i].Caption,
                                                    value: data.Data[0][data.MetaData[i].Name] + ' ' + currency
                                                });
                                            } else {
                                                reportViewModel.summary.push({ caption: data.MetaData[i].Caption, value: data.Data[0][data.MetaData[i].Name] });
                                            }
                                        }
                                    }
                                    for (var i = 0; i < reportViewModel.summary.peek().length; i++) {
                                        var sumEl = reportViewModel.summary.peek()[i];
                                    }
                                });
                        });

                    function _getInsertData(name, hash, that, event, next) {
                        TeG.Popups2.showDaisyWheelTotalHover();
                        $.ajax({
                            url: tegUrlHelper.casinoNetworkBalanceGrid1AggregatedDataRead,
                            type: "POST",
                            that: that,
                            event: event,
                            data: JSON.stringify({ reportParametersHashCode: hash, ParentLoginName: name }),
                            contentType: "application/json; charset=utf-8",
                            error: function (jqXHR) {
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                tegErrorHandler.processError(jqXHR, TeG.Translations.PopupError);
                            }
                        }).done(function (data) {
                            var that = this.that;
                            if (data.Data.length > 0) {
                                for (var rowNo in data.Data) {
                                    data.Data[rowNo].StatusHtml = TeG.Reports().Common().IconsStatuses[data.Data[rowNo].Status.toLowerCase()] || '';
                                }
                            }
                            if (typeof (next) === 'function') next(data, that, event);
                        });
                    }

                    $(document).on('click', '#ReportCasinoNetworkBalanceGrid1Grid .k-grid-content tr', { that: this }, function (event) {
                        if (/cnb-detail-block/.test($(this).find('td').eq(0).html())) {
                            return;
                        }

                        var imageCollapseRegex = new RegExp(TeG.Reports().Common().getImageGroupCollapse())
                        var imageExpandRegex = new RegExp(TeG.Reports().Common().getImageGroupExpand())
                        var index = event.data.that.index = $(this).prevAll().length;
                        var currentData = event.data.that.currentData = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.at(index);
                        event.data.that.uid = $(this).attr('data-uid');
                        var name = currentData.ParentLoginName;

                        var _highlight = function () {
                            $('#ReportCasinoNetworkBalanceGrid1Grid').find('tr').find('td[role="gridcell"] > .arrow-down').parents('tr').addClass('bold blue-top-tr');
                            $('#ReportCasinoNetworkBalanceGrid1Grid').find('tr').find('td[role="gridcell"] > .cnb-detail-block')
                                .parents('tr').addClass('blue-tr')
                                .next(":not(.blue-tr, .blue-top-tr)").prev().addClass('blue-bottom-tr');
                        };
                        var dsChangeEvents = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._events.change;
                        var isHightlightPresent = false;
                        for (i = 0; i < dsChangeEvents.length; i++) {
                            if (dsChangeEvents[i].toString() == _highlight.toString()) {
                                isHightlightPresent = true;
                            }
                        }
                        if (!isHightlightPresent) {
                            $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._events.change.push(_highlight);
                        }

                        if (imageCollapseRegex.test($(this).find('td').eq(0).html())) {
                            _getInsertData(name, getReportParametersHashCode().reportParametersHashCode, this, event, function (data, that, event) {
                                var totalFunction = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total;
                                var totalRecords = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total();
                                var currentData = event.data.that.currentData;
                                var index = event.data.that.index;
                                currentData['Name'] = currentData['Name'].replace(imageCollapseRegex, TeG.Reports().Common().getImageGroupExpand());
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.remove(currentData);
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.insert(index, currentData);
                                var insertData = data.Data
                                index++;
                                var kendoData = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.data();
                                for (var key = 0; key < insertData.length; key++) {
                                    insertData[key]['Name'] = '<span class="cnb-detail-block"></span>' + insertData[key]['Name'];
                                }
                                var kendoDataBeforeInsert = kendoData.splice(0, index);
                                var kendoDataAfterInsert = kendoData.splice(0, kendoData.length)
                                var newKendoData = kendoDataBeforeInsert.concat(insertData, kendoDataAfterInsert);
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.data(newKendoData);
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                                $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;
                                TeG.Popups().closeTotalHover();
                            });
                        } else if (imageExpandRegex.test($(this).find('td').eq(0).html())) {
                            var totalFunction = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total;
                            var totalRecords = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total();
                            currentData['Name'] = currentData['Name'].replace(imageExpandRegex, TeG.Reports().Common().getImageGroupCollapse());
                            index++;
                            var kendoData = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._data;
                            var startIndex = index;
                            while (typeof (kendoData[index]) != 'undefined' && /cnb-detail-block/.test(kendoData[index]['Name'])) {
                                index++;
                            }
                            var endIndex = index;
                            $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                            kendoData.splice(startIndex, endIndex - startIndex);
                            $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                            $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;
                        }
                        if (!/cnb-no-detail-block/.test($(this).find('td').eq(0).html())) {
                            $('.k-grid-content').eq(0).scrollTo($('[data-uid="' + event.data.that.uid + '"]'), 750);
                        }
                    });
                },

                DataBound: function (event) {
                    // restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);
                    $.each($('.role-type  '), function (key, value) {
                        if ($.trim($(value).html()) == 'Station') {
                            $(value).html('<img src = "/Images/icStation.png" title="Station" />');
                        } else if ($.trim($(value).html()) == 'Player') {
                            $(value).html('<img src = "/Images/icPlayer.png" title="Player" />');
                        } else if ($.trim($(value).html()) == 'Agent') {
                            $(value).html('<img src = "/Images/icAgent.png" title="Agent" />');
                        } else if ($.trim($(value).html()) == 'Master Agent') {
                            $(value).html('<img src = "/Images/icMasterAgent.png" title="Master Agent" />');
                        } else if ($.trim($(value).html()) == 'Administrator') {
                            $(value).html('<img src = "/Images/icAdministrator.png" title="Administrator" />');
                        } else if ($.trim($(value).html()) == 'Head Office') {
                            // TODO: clarify string "Head Office transaction"
                            $(value).html('<img src = "/Images/icHeadOffice.png" title="Head Office" />');
                        }
                    });

                    $.each($('.l-l-login'), function () {
                        var imgAltText = $(this).parent().find('.status-icon').find('img').attr('alt');
                        if (imgAltText === 'Lock' || imgAltText === 'NetworkLock' || imgAltText === 'NetworkLockForSuspend') {
                            $(this).removeClass('l-l-login').addClass('l-l-login-disabled');
                        }
                    });

                    var imageGroupCollapse = TeG.Reports().Common().getImageGroupCollapse();
                    var imgRegexCollapse = new RegExp(imageGroupCollapse);
                    var imageGroupExpand = TeG.Reports().Common().getImageGroupExpand();
                    var imageRegexExpand = new RegExp(imageGroupExpand);
                    var kendoData = $('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid').dataSource._data;
                    for (var i = 0; i < kendoData.length; i++) {
                        if (!imageRegexExpand.test(kendoData[i]['Name']) && !imgRegexCollapse.test(kendoData[i]['Name'])
                                && !/cnb-detail-block/.test(kendoData[i]['Name'])) {
                            if (kendoData[i]['SubMemberQty'] > 0) {
                                kendoData[i]['Name'] = imageGroupCollapse + kendoData[i]['Name'];
                            } else {
                                if (!/cnb-no-detail-block/.test(kendoData[i]['Name'])) {
                                    kendoData[i]['Name'] = '<span class="cnb-no-detail-block"></span>' + kendoData[i]['Name']
                                }
                            }
                        }
                    }
                    $('td.l-l-login').off();
                    $(document).on('click', 'td.l-l-login', { that: this }, function (event) {
                        var LLLogin = new TeG.Widget.Button.LoginToAccount;
                        var cell = this;
                        LLLogin.On().addListener('click', function () {
                            this.source.data.LoginName = $(cell).attr('data-account');
                        })
                        LLLogin.click();
                        event.stopImmediatePropagation();
                    });

                    $('#ReportCasinoNetworkBalanceGrid1Grid .k-grid-content tr').each(function () {
                        var index = $(this).prevAll().length
                        if (!imageRegexExpand.test($(this).find('td').eq(0).html()) && !imgRegexCollapse.test($(this).find('td').eq(0).html())
                                && !/cnb-detail-block/.test($(this).find('td').eq(0).html())) {
                            if (kendoData[index]['SubMemberQty'] > 0) {
                                $(this).find('td').eq(0).html(imageGroupCollapse + $(this).find('td').eq(0).html());
                            } else {
                                if (!/cnb-no-detail-block/.test($(this).find('td').eq(0).html())) {
                                    $(this).find('td').eq(0).html('<span class="cnb-no-detail-block"></span>' + $(this).find('td').eq(0).html());
                                }
                            }
                        }
                    })

                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle(TeG.Print.REPORT_SUMMARY_NOT_VISIBLE);
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportCasinoNetworkBalanceGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('CurrentNetwork/Balance');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                    setTimeout(splitterResize, 0); // HACK for paginator #TEGN-2134
                }
            }

        },
        //#endregion

        //#region Integrity
        Integrity: function () {
            return {
                Show: function () {
                    //                    reportViewModel.activate($('#report').get(0));
                    TeG.Utils().customSelectBehaivor();

                    function _getInsertData(name, hash, that, event, next) {
                        TeG.Popups2.showDaisyWheelTotalHover();
                        $.ajax({
                            url: tegUrlHelper.integrityGrid1AggregatedDataRead,
                            type: "POST",
                            that: that,
                            event: event,
                            data: JSON.stringify({ reportParametersHashCode: hash, parentMemberId: name }),
                            contentType: "application/json; charset=utf-8",
                            error: function (jqXHR) {
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                tegErrorHandler.processError(jqXHR, TeG.Translations.PopupError);
                            }
                        }).done(function (data) {
                            var that = this.that;
                            if (typeof (next) == 'function') next(data, that, event);
                        });
                    }

                    if (reportViewModel.getType() == 'HO') {
                        $(document).on('click', '#ReportIntegrityGrid1Grid .k-grid-content tr', { that: this }, function (event) {
                            if (/cnb-detail-block/.test($(this).find('td').eq(0).html())) {
                                return;
                            }

                            var imageCollapseRegex = new RegExp(TeG.Reports().Common().getImageGroupCollapse())
                            var imageExpandRegex = new RegExp(TeG.Reports().Common().getImageGroupExpand())
                            var index = event.data.that.index = $(this).prevAll().length;
                            var currentData = event.data.that.currentData = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.at(index);
                            event.data.that.uid = $(this).attr('data-uid');
                            var name = currentData.ParentMemberId;

                            var _highlight = function () {
                                $('#ReportIntegrityGrid1Grid').find('tr').find('td[role="gridcell"] > .arrow-down').parents('tr').addClass('bold blue-top-tr');
                                $('#ReportIntegrityGrid1Grid').find('tr').find('td[role="gridcell"] > .cnb-detail-block')
                                    .parents('tr').addClass('blue-tr')
                                    .next(":not(.blue-tr, .blue-top-tr)").prev().addClass('blue-bottom-tr');
                            };
                            var dsChangeEvents = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._events.change;
                            var isHightlightPresent = false;
                            for (i = 0; i < dsChangeEvents.length; i++) {
                                if (dsChangeEvents[i].toString() == _highlight.toString()) {
                                    isHightlightPresent = true;
                                }
                            }
                            if (!isHightlightPresent) {
                                $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._events.change.push(_highlight);
                            }

                            if (imageCollapseRegex.test($(this).find('td').eq(0).html())) {
                                _getInsertData(name, getReportParametersHashCode().reportParametersHashCode, this, event, function (data, that, event) {
                                    var totalFunction = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total;
                                    var totalRecords = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total();
                                    var currentData = event.data.that.currentData;
                                    var index = event.data.that.index;
                                    currentData['MasterAgentAgentName'] = currentData['MasterAgentAgentName'].replace(imageCollapseRegex, TeG.Reports().Common().getImageGroupExpand());
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.remove(currentData);
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.insert(index, currentData);
                                    var insertData = data.Data
                                    index++;
                                    var kendoData = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.data();
                                    for (var key = 0; key < insertData.length; key++) {
                                        insertData[key]['MasterAgentAgentName'] = '<span class="cnb-detail-block"></span>' + insertData[key]['MasterAgentAgentName'];
                                    }
                                    var kendoDataBeforeInsert = kendoData.splice(0, index);
                                    var kendoDataAfterInsert = kendoData.splice(0, kendoData.length)
                                    var newKendoData = kendoDataBeforeInsert.concat(insertData, kendoDataAfterInsert);
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.data(newKendoData);
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                                    $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;
                                    TeG.Popups().closeTotalHover();
                                });
                            } else if (imageExpandRegex.test($(this).find('td').eq(0).html())) {
                                var totalFunction = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total;
                                var totalRecords = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total();
                                currentData['MasterAgentAgentName'] = currentData['MasterAgentAgentName'].replace(imageExpandRegex, TeG.Reports().Common().getImageGroupCollapse());
                                index++;
                                var kendoData = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._data;
                                var startIndex = index;
                                while (typeof (kendoData[index]) != 'undefined' && /cnb-detail-block/.test(kendoData[index]['MasterAgentAgentName'])) {
                                    index++;
                                }
                                var endIndex = index;
                                $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total = function () { return totalRecords; }
                                kendoData.splice(startIndex, endIndex - startIndex);
                                $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource.total = totalFunction;
                                $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._total = totalRecords;
                            }
                            if (!/cnb-no-detail-block/.test($(this).find('td').eq(0).html())) {
                                $('.k-grid-content').eq(0).scrollTo($('[data-uid="' + event.data.that.uid + '"]'), 750);
                            }
                        });
                    }

                    $('#searchReport').on('click', { that: this }, function () {
                        tegPopups.showTotalHover();
                        reportViewModel.searchStart();
                        TeG.Reports().GetReportData(JSON.stringify(reportViewModel.getRequestData()), tegUrlHelper.integridyGrid1, $('#reportGridData'));
                    });
                },
                DataBound: function (event) {
                    //restoreColumnsWidthes(event);
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    reportViewModel.summaryData$visible(true);
                    TeG.Reports().Common().DataBoundKO(event);
                    if (reportViewModel.getType() == 'HO') {
                        var imageGroupCollapse = TeG.Reports().Common().getImageGroupCollapse();
                        var imgRegexCollapse = new RegExp(imageGroupCollapse);
                        var imageGroupExpand = TeG.Reports().Common().getImageGroupExpand();
                        var imageRegexExpand = new RegExp(imageGroupExpand);
                        var kendoData = $('#ReportIntegrityGrid1Grid').data('kendoGrid').dataSource._data;
                        for (var i = 0; i < kendoData.length; i++) {
                            if (!imageRegexExpand.test(kendoData[i]['MasterAgentAgentName']) && !imgRegexCollapse.test(kendoData[i]['MasterAgentAgentName'])
                                && !/cnb-detail-block/.test(kendoData[i]['MasterAgentAgentName'])) {
                                kendoData[i]['MasterAgentAgentName'] = imageGroupCollapse + kendoData[i]['MasterAgentAgentName'];
                            }
                        }
                        $('#ReportIntegrityGrid1Grid .k-grid-content tr').each(function () {
                            if (!imageRegexExpand.test($(this).find('td').eq(0).html()) && !imgRegexCollapse.test($(this).find('td').eq(0).html())
                                    && !/cnb-detail-block/.test($(this).find('td').eq(0).html())) {
                                $(this).find('td').eq(0).html(imageGroupCollapse + $(this).find('td').eq(0).html());
                            }
                        })
                    }
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        reportViewModel.storeTitle($.trim($('#gridToolBarContentName').html()));
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportIntegrityGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Integrity');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region IPLogin
        IPLogin: function () {
            return {

                Show: function () {
                    TeG.Utils().customSelectBehaivor();

                    var startMinDate = moment().utc();
                    var startMaxDate = moment().utc();

                    startMinDate.month(startMinDate.month() - 1).date(1);

                    function initDatePickers() {
                        startMaxDate.hours(startMaxDate.hours() + parseInt(TeG.GlobalVariables.timeDiff));

                        $('#fromDate').kendoDatePicker({
                            value: startMinDate.format('DD-MM-YYYY'),
                            min: startMinDate.toDate(),
                            // max: new Date(startMaxDate.format('MM-DD-YYYY')),
                            max: new Date(startMaxDate.year(), startMaxDate.month(), startMaxDate.date()),
                            format: "dd-MM-yyyy"
                        });
                        reportViewModel.date.fromDate($('#fromDate').val());

                        $('#toDate').kendoDatePicker({
                            value: startMaxDate.format('DD-MM-YYYY'),
                            min: startMinDate.toDate(),
                            //max: new Date(startMaxDate.format('DD-MM-YYYY')),
                            // max: new Date(startMaxDate.format('MM-DD-YYYY')),
                            max: new Date(startMaxDate.year(), startMaxDate.month(), startMaxDate.date()),
                            format: "dd-MM-yyyy"
                        });
                        reportViewModel.date.toDate($('#toDate').val());

                        $('.k-widget.k-datepicker.k-header.k-input').width(200);
                    }

                    if (TeG.GlobalVariables.timeDiff != undefined) {
                        initDatePickers();
                    } else {
                        $(document).one('GlobalVariablesTimeDiffReady', initDatePickers);
                    }
                },

                Submit: function (requestData) {
                    tegPopups.showTotalHover();
                    reportViewModel.searchStart();
                    TeG.Reports().GetReportData(JSON.stringify(reportViewModel.getRequestData()), tegUrlHelper.iPLoginGrid1, $('#reportGridData'));
                },

                DataBound: function (event) {
                    //restoreColumnsWidthes(event);
                    //reportViewModel.getSearchParameter().isSummaryReceived = true;
                    //reportViewModel.summaryData$visible(true);
                    TeG.Reports().Common().DataBoundKO(event);

                    if (TeG.isMobile()) {
                        $('.reportRequire').hide();
                        $('#reportHeaderContainer').addClass('collapsed');
                        $('.expandSearch').show();
                        reportViewModel.displayHeadRequest(true);
                    }

                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        reportViewModel.storeTitle($.trim($('#gridToolBarContentName').html()));
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportIntegrityGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Integrity');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            };
        },
        //#endregion

        //#region Gar
        Gar: function () {
            return {
                Show: function () {
                    reportViewModel.activate($('#report').get(0));
                    $('#searchReport').on('click', { that: this }, function () {
                        tegPopups.showTotalHover();
                        reportViewModel.searchStart();
                        if (reportViewModel.masterAgentCurrency() && reportViewModel.selectedMA() != "") {
                            var summaryMethod = TeG.Reports().GetGarReportSummary;
                        } else {
                            var summaryMethod = TeG.Reports().GetReportSummaryDataKO;
                        }
                        TeG.Reports().GetReportData(JSON.stringify(reportViewModel.getRequestData()), tegUrlHelper.gameAnalysesGrid, $('#reportGridData'),
                        function () {
                            var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                            summaryMethod(tegUrlHelper.gameAnalysisSummaryRead + '?reportParametersHashCode=' + reportParametersHashCode);
                        });
                    });
                    /*
                    $('#drop-down-list-top-MA').on('click', function(event) {
                        event.stopImmediatePropagation();
                        $('#select-MA').find('.k-select').click();
                    });
                    $('.drop-down-list-select').toggle()
                    $('.drop-down-list-select').on('click', function(event) {
                        event.stopImmediatePropagation();
                    })
                    */
                },

                DataBinding: function (event) {

                },

                DataBound: function (event) {
                    // restoreColumnsWidthes(event);                    
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    //reportViewModel.summaryData$visible(true);
                    if (reportViewModel.masterAgentCurrency() && reportViewModel.selectedMA() != "") {
                        reportViewModel.summaryData$visible(false);
                        reportViewModel.SummaryDataMultiCurrency$visible(true);
                    } else {
                        reportViewModel.summaryData$visible(true);
                        reportViewModel.SummaryDataMultiCurrency$visible(false);
                    }
                    TeG.Reports().Common().DataBoundKO(event);
                    //collapseMenuOnScroll();
                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        reportViewModel.storeTitle($.trim($('#gridToolBarContentName').html()));
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        gridPrint.setGrid($('#ReportGameAnalysisGrid1Grid').data('kendoGrid'));
                        gridPrint.setTitle('Game Analysis');
                        gridPrint.store();
                        gridPrint.openReport();
                    });

                }
            }

        },
        //#endregion

        //#region Billing

        Billing: function() {
            return {
                Show: function () {
                    $("#body-pane-loader").hide();
                    $("#body-pane-content").show();

                    /*Global Search*/
                    $(".globalSearchInput ").on("focus", function (e) {
                        $(this).val('');
                    });
                    $(".globalSearchInput ").on("keyup", function (e) {
                        e.preventDefault();

                        $('#cancelSearch').show();
                        if ($.browser.safari && !TeG.isMobile() && !TeG.isIPad()) {
                            $('#cancelSearch').css('left', '170px');
                        }

                        $('#cancelSearch').unbind('click').bind('click', function (event) {

                            var grid = $('[data-role="grid"]').data('kendoGrid');
                            // Refresh filters
                            grid.dataSource.filter({});

                            $(".globalSearchInput ").val('');
                            $('#cancelSearch').hide();
                        });

                        if (e.which == kendo.keys.ENTER) {
                            var filter = { logic: "or", filters: [] };
                            $searchValue = $(this).val();
                            if ($searchValue) {
                                $.each($("#reportGridData").data("kendoGrid").columns, function (key, column) {
                                    if (column.filterable && column.type == 'string') {
                                        filter.filters.push({ field: column.field, operator: "contains", value: $searchValue });
                                    }
                                    if (column.filterable && column.type == "date") {
                                        // Date doesn't participate in global search
                                    }
                                    if (column.filterable && column.type == "number" && $.isNumeric($searchValue)) {
                                        // Numeric fields participate in global search as numeric and not string values
                                        filter.filters.push({ field: column.field, operator: "eq", value: parseFloat($searchValue) });
                                    }
                                });
                            }
                            //$("#reportGridData").data("kendoGrid").dataSource.query({ filter: filter });
                            $("#reportGridData").data("kendoGrid").dataSource.filter(filter);
                        }
                    });
                    /*End - Global Search*/
                    
                    reportViewModel.activate($('#report').get(0));
                },

                Submit: function () {

                    var culturesMap = {
                        //'en': 'en-US',
                        'ch': 'zh-CN',
                        'tw': 'zh-TW',
                        'ja': 'ja-JP'
                    }

                    tegPopups.showTotalHover();
                    reportViewModel.searchStart();

                    var sendData = reportViewModel.GetSendData();

                    function createGrid() {

                        var grid = $('#reportGridData').data('kendoGrid');

                        if (grid != undefined) {
                            grid.destroy();
                            $('#reportGridData').children().remove();
                        }

                        var dataSourceSchema = TeG.Reports().Config.Billing.DataSourceSchema;

                        //#region Main grid definition
                        $('#reportGridData').kendoGrid({
                            //autoBind: false,
                            //#region DataSource
                            //toolbar: ["excel"],
                            excel: {
                                allPages: true,
                                fileName: "Billing.xlsx",
                                forceProxy: true,
                                proxyURL: tegUrlHelper.export,
                                filterable: true
                            },
                            dataSource: {
                                type: 'aspnetmvc-ajax',
                                transport: {
                                    read: {
                                        // the remote service url
                                        url: tegUrlHelper.billing,
                                        // the request type
                                        type: "post",
                                        // the data type of the returned result
                                        dataType: "json",
                                        // additional custom parameters sent to the remote service
                                        data: sendData
                                    }
                                },

                                schema: dataSourceSchema,
                                serverPaging: true,
                                serverFiltering: true,
                                serverSorting: true
                            },
                            //#endregion DataSource

                            pageable: {
                                pageSize: 25,
                                pageSizes: [25, 50, 100]
                            },
                            resizable: true,
                            sortable: {
                                allowUnsort: false
                            },
                            columnResize: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnReorder: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnShow: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnHide: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            scrollable: true,
                            filterable: true,
                            columnMenu: true,
                            columns: TeG.Reports().Config.Billing.columnsArr,
                            dataBound: function (event) {
                                var that = this;

                                reportViewModel.reportData$visible(true);

                                if (that.dataSource.total() > 0) {
                                    reportViewModel.gridData$visible(true);
                                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                                    reportViewModel.summaryData$visible(true);

                                    reportViewModel.titleNoData$visible(false);
                                } else {
                                    reportViewModel.gridData$visible(false);
                                    reportViewModel.getSearchParameter().isSummaryReceived = false;
                                    reportViewModel.summaryData$visible(false);

                                    reportViewModel.titleNoData$visible(true);
                                }
                                
                                reportViewModel.loading$class(false);
                                tegPopups.closeTotalHover();

                                TeG.Reports().Common().DataBoundKO(event);
                                //TeG.Reports().Common().DataBound(event);

                                // Tooltips initialization
                                if (!TeG.isMobile() && !this.tooltipInitialized) {
                                    // @this = grid
                                    this.thead.kendoTooltip({
                                        filter: "th:not(.k-hierarchy-cell)",
                                        content: function (e) {
                                            var target = e.target; // element for which the tooltip is shown
                                            that.tooltipInitialized = true;
                                            return $(target).text();
                                        }
                                    });
                                }
                            }
                        });

                        var grid = $('#reportGridData').data('kendoGrid');
                        //TeG.Grid.Options.Restore(grid);

                    }

                    // Print grid

                    //$('#linkPrint').off();
                    //$('#linkPrint').on('click', { that: this }, function (event) {
                    //    reportViewModel.storeTitle($.trim($('#gridToolBarContentName').html()));
                    //    TeG.Reports().StoreSummary();
                    //    var gridPrint = new (TeG.Print()).PrintGrid();
                    //    gridPrint.setGrid($('#reportGridData').data('kendoGrid'));
                    //    gridPrint.setTitle(TeG.Translations.MenuBillingReport);
                    //    gridPrint.store();
                    //    gridPrint.openReport();
                    //});
                    $('#linkPrint').click(function () {
                        printGrid($("#reportGridData"));
                    });

                    // End Print grid

                    // Excel export
                    $('#exportLink').removeAttr('onclick');
                    $('#exportLink').unbind('click').bind('click', function (e) {
                        e.preventDefault();
                        var grid = $('#reportGridData').data('kendoGrid');
                        grid.bind("excelExport", function (e) {
                            e.workbook.fileName = "BillingReport.xlsx";
                        });
                        grid.saveAsExcel();
                    });
                    // End Excel export

                    // Kendo translations
                    $.getScript(location.origin + "/Scripts/kendo/" + kendo.version + "/messages/kendo.messages." + (culturesMap[culture] || 'en-US') + ".min.js", function () {
                        kendo.ui.progress($("#reportGridData"), false);
                        createGrid();
                    });
           
                }
            };
        },

        //#endregion Billing

        //#region GetPlayersGrossWinReportSummary
        GetPlayersGrossWinReportSummary: function (path, reportDataElem) {

            searchReportFlow = reportViewModel.getSearchParameter();
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    reportViewModel.showReport();
                    if (typeof (searchReportFlow) != 'undefined') {
                        searchReportFlow.isSummaryReceive = true;
                        searchReportFlow.isSummaryEmpty = true;
                    }
                    TeG.Reports().Common().ShowReport();
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                // Storing responce in model's property.
                reportViewModel.responseData = data;

                reportViewModel.getSearchParameter().isSummaryReceive = true;
                if (data.Data && data.Data.length == 0) {
                    reportViewModel.getSearchParameter().isSummaryEmpty = true;
                    reportViewModel.summaryData$visible(false);
                    //return;
                } else {
                    reportViewModel.getSearchParameter().isSummaryEmpty = false;
                    reportViewModel.summaryData$visible(true);
                }


                // Whole request data will be stored in view model.
                reportViewModel.summaryData = [];

                if (reportViewModel.getSearchParameter().isSummaryEmpty == false) {
                    for (var i = 0; i < data.Data.length; i++) {
                        reportViewModel.summaryData[data.Data[i].CurrencyId] = data.Data[i];
                    }

                    $('#multi-currency-select').off();
                    var currencies = new Object;
                    var selectCurrencyCaption = data.MetaData.shift().Caption;

                    reportViewModel.summaryDataToShow.removeAll();

                    reportViewModel.selectCurrencyCaption = ko.observable('Currency');

                    // population of options
                    reportViewModel.summaryAvailableCurrencies.removeAll();
                    for (i = 0; i < data.Data.length; i++) {
                        reportViewModel.summaryAvailableCurrencies.push({ currencyIso: data.Data[i].Currency, currencyId: data.Data[i].CurrencyId });
                    }

                    // population summary by data
                    populateSummaryData();
                }

                function populateSummaryData(index) {
                    var dataCurrencyValue = null;
                    var dataCurrencyCaption = null;

                    reportViewModel.summaryDataToShow.removeAll();

                    for (meta in reportViewModel.responseData.MetaData) {
                        dataCurrencyCaption = reportViewModel.responseData.MetaData[meta].Caption;

                        // Fixing inconsistency between columns names in Data and MetaData
                        // @todo should be fixed on server side
                        if (dataCurrencyCaption == 'Payouts') {
                            dataCurrencyCaption = 'Payout';
                        }
                        else if (dataCurrencyCaption == 'Gross Win') {
                            dataCurrencyCaption = 'GrossWin';
                        }

                        if (index === undefined) {
                            dataCurrencyValue = data.Data[0][dataCurrencyCaption];
                        }
                        else {
                            dataCurrencyValue = reportViewModel.summaryData[index][dataCurrencyCaption];
                        }

                        reportViewModel.summaryDataToShow.push({ dataCurrencyCaption: dataCurrencyCaption, dataCurrencyValue: dataCurrencyValue });
                    }
                }

                $('#multi-currency-select').on('change', { reportViewModel: multiCurrencyViewModel }, function (event) {
                    populateSummaryData(this.value);
                });

                //reportViewModel.loading$class(false);
                //TeG.Popups().closeTotalHover();
                //reportViewModel.reportData$visible(true);
                //reportViewModel.gridShow();

                // TeG.Reports().Common().ShowReport();
                reportViewModel.showReport();
                splitterResize();
            });
        },
        //#endregion

        GetGarReportSummary: function (path, reportDataElem) {

            searchReportFlow = reportViewModel.getSearchParameter();
            $.ajax({
                url: path,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (jqXHR) {
                    reportViewModel.showReport();
                    if (typeof (searchReportFlow) != 'undefined') {
                        searchReportFlow.isSummaryReceive = true;
                        searchReportFlow.isSummaryEmpty = true;
                    }
                    TeG.Reports().Common().ShowReport();
                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                    tegErrorHandler.processError(jqXHR);
                }
            }).done(function (data) {
                //console.log(data);
                // Storing responce in model's property.
                reportViewModel.responseData = data;
                var defaultCurrency = null;

                reportViewModel.getSearchParameter().isSummaryReceive = true;
                if (data.Data && data.Data.length == 0) {
                    reportViewModel.getSearchParameter().isSummaryEmpty = true;
                    reportViewModel.summaryData$visible(false);
                    reportViewModel.SummaryDataMultiCurrency$visible(false);
                } else {
                    reportViewModel.getSearchParameter().isSummaryEmpty = false;
                    reportViewModel.summaryData$visible(false);
                    reportViewModel.SummaryDataMultiCurrency$visible(true);
                }


                // Whole request data will be stored in view model.
                reportViewModel.summaryData = [];

                if (reportViewModel.getSearchParameter().isSummaryEmpty == false) {
                    for (var i = 0; i < data.Data.length; i++) {
                        reportViewModel.summaryData[data.Data[i].CurrencyId] = data.Data[i];
                    }

                    $('#multi-currency-select').off();
                    var currencies = new Object;
                    var selectCurrencyCaption = data.MetaData.shift().Caption;

                    reportViewModel.summaryDataToShow.removeAll();

                    reportViewModel.selectCurrencyCaption = ko.observable('Currency');

                    // population of options
                    reportViewModel.summaryAvailableCurrencies.removeAll();
                    for (i = 0; i < data.Data.length; i++) {
                        //Find not HO currency
                        if (data.Data[i].CurrencyId != $('#loginCurrencyId').val()) {
                            defaultCurrency = data.Data[i].CurrencyId;
                        }
                        reportViewModel.summaryAvailableCurrencies.push({ currencyIso: data.Data[i].Currency, currencyId: data.Data[i].CurrencyId });
                    }

                    // population summary by data
                    populateSummaryData();
                }

                function populateSummaryData(index) {
                    var dataCurrencyValue = null;
                    var dataCurrencyCaption = null;
                    var dataCurrencyName = null;

                    reportViewModel.summaryDataToShow.removeAll();

                    for (meta in reportViewModel.responseData.MetaData) {
                        dataCurrencyCaption = reportViewModel.responseData.MetaData[meta].Caption;
                        dataCurrencyName = reportViewModel.responseData.MetaData[meta].Name;

                        if (index === undefined) {
                            dataCurrencyValue = data.Data[0][dataCurrencyName];
                        }
                        else {
                            dataCurrencyValue = reportViewModel.summaryData[index][dataCurrencyName];
                        }

                        reportViewModel.summaryDataToShow.push({ dataCurrencyCaption: dataCurrencyCaption, dataCurrencyValue: dataCurrencyValue });
                    }
                }

                if (defaultCurrency != null) {
                    populateSummaryData(defaultCurrency);
                    $("#multi-currency-select").val(defaultCurrency);
                }

                $('#multi-currency-select').on('change', { reportViewModel: multiCurrencyViewModel }, function (event) {
                    populateSummaryData(this.value);
                });
                

                //reportViewModel.loading$class(false);
                //TeG.Popups().closeTotalHover();
                //reportViewModel.reportData$visible(true);
                //reportViewModel.gridShow();

                // TeG.Reports().Common().ShowReport();
                //reportViewModel.showReport();
                //splitterResize();
            });
        },
        //#endregion
        //#region PlayersGrossWin
        PlayersGrossWin: function () {
            return {
                Show: function () {
                    TeG.Utils().customSelectBehaivor();


                    $('#searchReport').on('click', { that: this }, function () {
                        tegPopups.showTotalHover();
                        reportViewModel.searchStart();
                        reportViewModel.showReportReset();
                        TeG.Reports().GetReportData(JSON.stringify(reportViewModel.getRequestData()), tegUrlHelper.getPlayerGrossWin, $('#reportGridData'), function () {

                            var summaryMethod = TeG.Reports().GetPlayersGrossWinReportSummary;

                            var reportParametersHashCode = getReportParametersHashCode().reportParametersHashCode;
                            summaryMethod(tegUrlHelper.getPlayerGrossWinSummary + '?reportParametersHashCode=' + reportParametersHashCode);
                        });
                    });

                    tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                },

                DataBound: function (event) {
                    //restoreColumnsWidthes(event);
                    TeG.Reports().Common().DataBoundKO(event);
                    reportViewModel.showReport();


                    $('#linkPrint').off();
                    $('#linkPrint').on('click', { that: this }, function (event) {
                        TeG.Reports().StoreTitle();
                        TeG.Reports().StoreSummary();
                        var gridPrint = new (TeG.Print()).PrintGrid();
                        if (!($('select[name="groupingType"]').val() == 'Daterange' && $('#select-subordinates').index() == -1)) {
                            gridPrint.setGrid($('#ReportPlayerGrossWinGrid1Grid').data('kendoGrid'));
                        }
                        gridPrint.setTitle('Player Gross Win');
                        gridPrint.store();
                        gridPrint.openReport();
                    });
                }
            }
        },
        //#endregion

        //#region LiveGamesFraudCheck
        LiveGamesFraudCheck: function () {

            var columns = TeG.Reports().Config.LiveGamesFraudCheck.columnsArr;
            //var LDTransactionByRound = [];

            if (memberType == 'MasterAgent') {
                columns.splice(2, 1);
            }

            function innerGridsCounter() {
                var counter = 0;

                return function () {
                    return ++counter;
                };
            };
            var innerGridOrder = innerGridsCounter();

            //#region Drill Down Report*/
            /*Drill Down Report*/
            function gridDetailInit(e) {
                // @this = grid
                var innerGridOrderValue = innerGridOrder();

                var requestData = {
                    //AccountName: e.data.AccountName,
                    Game: reportViewModel.getRequestData().Game,
                    RoundId: e.data.RoundId,
                    TableCode: e.data.TableCode,
                    FromDate: reportViewModel.getRequestData().FromDate,
                    ToDate: reportViewModel.getRequestData().ToDate
                }

                //var resultTransactionsByRound = [];

                tegPopups.showTotalHover();

                // Unselect previos selected rows
                //$(e.masterRow).siblings().removeClass('k-state-selected');
                // Selecting parent row in parent grid
                //$(e.masterRow).addClass('k-state-selected');

                //$(LDTransactionByRound).each(function () {
                //    if (this.RoundId == e.data.RoundId && this.TableCode == e.data.TableCode) {
                //        resultTransactionsByRound.push(this);
                //    }
                //});

                //if ($.isArray(resultTransactionsByRound) && resultTransactionsByRound.length == 0) {
                //    $("<div/>").appendTo(e.detailCell).html('<div align="center"><h2>' + TeG.Translations.NoData + '</h2></div>');
                //    tegPopups.closeTotalHover();
                //}
                //else {
                    $("<div/>").appendTo(e.detailCell).kendoGrid({
                        //dataSource: {
                        //    data: resultTransactionsByRound,
                        //    schema: TeG.Reports().Config.LiveGamesFraudCheck.dataSourceSchemaInit,
                        //    sort: { field: "PlaceBetTime", dir: "desc" }
                        //},
                        dataSource: {
                            type: "json",
                            transport: {
                                read: {
                                    // the remote service url
                                    url: tegUrlHelper.getLiveGamesFraudCheckReport,
                                    // the request type
                                    type: "post",
                                    // the data type of the returned result
                                    dataType: "json",
                                    // additional custom parameters sent to the remote service
                                    data: requestData,
                                },
                            },
                        },
                        sortable: true,
                        // selectable: true,
                        columns: columns,
                        dataBound: function (event) {
                            // @this = grid
                            
                            if (this.dataSource.data().length == 0) {
                                // There is no data received
                                $("<div/>").appendTo(e.detailCell).html('<div align="center"><h2>' + TeG.Translations.NoData + '</h2></div>');
                                // Removing grid
                                this.element.remove();
                                this.destroy();
                                tegPopups.closeTotalHover();
                                return;
                            }

                            var that = this;
                            this.element.attr('id', 'reportGridDrillDownData-' + innerGridOrderValue);

                            tegPopups.closeTotalHover();
                            $(event.sender.thead).parent().parent().parent().css({ 'padding-right': 0 });
                            event.sender.element.parent().parent().show();

                            // Tooltips initialization
                            if (!TeG.isMobile() && !this.tooltipInitialized) {
                                //@this = grid
                                this.thead.kendoTooltip({
                                    filter: "th",
                                    content: function (e) {
                                        var target = e.target; // element for which the tooltip is shown
                                        that.tooltipInitialized = true;
                                        return $(target).text();
                                    }
                                });
                            }
                        },
                        //columnResize: function (e) {
                        //    TeG.Grid.Options.Store(e);
                        //},
                        //columnReorder: function (e) {
                        //    TeG.Grid.Options.Store(e);
                        //},
                        //columnShow: function (e) {
                        //    TeG.Grid.Options.Store(e);
                        //},
                        //columnHide: function (e) {
                        //    TeG.Grid.Options.Store(e);
                        //}
                    });
                //}
            }
            /*End - Drill Down Report*/
            //#endregion Drill Down Report*/

            return {
                //#region Show
                Show: function () {
                    //#region Init report form filter
                    /*Init report form filter*/
                    $('#account-name').focus();
                    TeG.Utils().customSelectBehaivor();

                    var startMinDate = moment().utc();
                    var startMaxDate = moment().utc();

                    startMinDate.date(startMinDate.date() - 6);

                    function initDatePickers() {

                        $('#fromDate').kendoDatePicker({
                            value: startMaxDate.format('DD-MM-YYYY'),
                            min: startMinDate.toDate(),
                            max: startMaxDate.toDate(),
                            format: "dd-MM-yyyy"
                        });
                        reportViewModel.date.fromDate($('#fromDate').val());

                        $('#toDate').kendoDatePicker({
                            value: startMaxDate.format('DD-MM-YYYY'),
                            min: startMinDate.toDate(),
                            max: startMaxDate.toDate(),
                            format: "dd-MM-yyyy"
                        });
                        reportViewModel.date.toDate($('#toDate').val());

                        $('.k-widget.k-datepicker.k-header.k-input').width(200);
                        $('#games').width(160);
                        $('#account-name, #round-id').width(150);
                    }

                    initDatePickers();

                    $.ajax({
                        url: tegUrlHelper.getLdGames,
                        type: "POST",
                        error: function (jqXHR) {
                            tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                            tegErrorHandler.processError(jqXHR, TeG.Translations.PopupError);
                        }
                    }).done(function (data) {
                        reportViewModel.GameTypeObservable(data);
                        reportViewModel.choosenGame().push(reportViewModel.GameTypeObservable()[0]);
                    });
                    /*End - Init report form filter*/
                    //#endregion

                    //#region Events binding

                    //#region Print Report
                    /*Print Report*/
                    $('#linkPrint').click(function () {
                        printGrid($("#reportGridData"));
                    });
                    /*End - Print Report*/
                    //#endregion Print Report

                    //#region Global Search
                    /*Global Search*/
                    $(".globalSearchInput ").on("focus", function (e) {
                        $(this).val('');
                    });
                    $(".globalSearchInput ").on("keyup", function (e) {
                        e.preventDefault();

                        $('#cancelSearch').show();
                        if ($.browser.safari && !TeG.isMobile() && !TeG.isIPad()) {
                            $('#cancelSearch').css('left', '170px');
                        }

                        $('#cancelSearch').unbind('click').bind('click', function (event) {

                            var grid = $('[data-role="grid"]').data('kendoGrid');
                            // Refresh filters
                            grid.dataSource.filter({});

                            $(".globalSearchInput ").val('');
                            $('#cancelSearch').hide();
                        });

                        if (e.which == kendo.keys.ENTER) {
                            var filter = { logic: "or", filters: [] };
                            $searchValue = $(this).val();
                            if ($searchValue) {
                                $.each($("#reportGridData").data("kendoGrid").columns, function (key, column) {
                                    if (column.filterable && column.type == 'string') {
                                        filter.filters.push({ field: column.field, operator: "contains", value: $searchValue });
                                    }
                                    if (column.filterable && column.type == "date") {
                                        // Date doesn't participate in global search
                                    }
                                    if (column.filterable && column.type == "number" && $.isNumeric($searchValue)) {
                                        // Numeric fields participate in global search as numeric and not string values
                                        filter.filters.push({ field: column.field, operator: "eq", value: parseFloat($searchValue) });
                                    }
                                });
                            }
                            //$("#reportGridData").data("kendoGrid").dataSource.query({ filter: filter });
                            $("#reportGridData").data("kendoGrid").dataSource.filter(filter);
                        }
                    });
                    /*End - Global Search*/
                    //#endregion Global Search
                    //#endregion Events binding
                },
                //#endregion
                //#region Submit
                Submit: function (e) {

                    var culturesMap = {
                        //'en': 'en-US',
                        'ch': 'zh-CN',
                        'tw': 'zh-TW',
                    }

                    function createGrid() {

                        reportViewModel.refreshFields();
                        if (reportViewModel.hasErrors()) {
                            return;
                        }

                        var grid = $('#reportGridData').data('kendoGrid');

                        if (grid != undefined) {
                            grid.destroy();
                            $('#reportGridData').children().remove();
                        }

                        tegPopups.showTotalHover();
                        var requestData = reportViewModel.getRequestData();

                        var drillDown = (!requestData.AccountNumber && requestData.RoundId)? false : true;

                        reportViewModel.searchStart();

                        var dataSourceSchema = {
                            //data: 'LDTransactionByAccount',
                            //parse: function (response) {
                            //    LDTransactionByRound = response.LDTransactionByRound;
                            //    return response;
                            //},
                            //total: function (response) {
                            //    return response.Total;
                            //},
                            model: TeG.Reports().Config.LiveGamesFraudCheck.dataSourceSchemaInit.model
                        };

                        //#region Main grid definition
                        $('#reportGridData').kendoGrid({

                            //#region DataSource
                            dataSource: {
                                type: "json",
                                transport: {
                                    read: {
                                        // the remote service url
                                        url: tegUrlHelper.getLiveGamesFraudCheckReport,
                                        // the request type
                                        type: "post",
                                        // the data type of the returned result
                                        dataType: "json",
                                        // additional custom parameters sent to the remote service
                                        data: requestData,

                                        statusCode: {
                                            500: function (e) {
                                                if (e.responseJSON.ExceptionMessage.indexOf('CUSTOMERDOESNOTBELONGSTOMEMBER') != -1 || e.responseJSON.ExceptionMessage.indexOf('CUSTOMERDOESNOTEXISTS') != -1) {
                                                    $('#errorClose').click();
                                                    reportViewModel.reportData$visible(true);
                                                    reportViewModel.titleNoGamePlayData$visible(false);
                                                    reportViewModel.titleNoData$visible(true);
                                                    TeG.Reports().DisableToolBar();
                                                }
                                            }
                                        }
                                    },
                                    //#region parameterMap
                                    //parameterMap: function (options) {
                                    //    var result = {};

                                    //    for (prop in options) {
                                    //        result[prop] = options[prop];
                                    //    }

                                    //    // Parameters map for sorting
                                    //    if (options.sort && $.isArray(options.sort) && options.sort[0]) {
                                    //        result.sort = options.sort[0].field + '-' + options.sort[0].dir;
                                    //    }

                                    //    // Parameters map for filtering
                                    //    if (options.filter && options.filter.filters && $.isArray(options.filter.filters)) {

                                    //        // Global search handling
                                    //        if (options.filter.filters.length > 0 && options.filter.filters[0].isGlobalSearch) {
                                    //            var grid = $('div#reportGridData').data('kendoGrid');

                                    //            result.filter = options.filter.filters[0].field + '-' + options.filter.filters[0].value;
                                    //            result.pageSize = grid.options.dataSource.pageSize;
                                    //            result.page = 1;
                                    //            return result;
                                    //        } else {
                                    //            result.filter = '';
                                    //        }

                                    //        $(options.filter.filters).each(function () {
                                    //            if (this.filters && $.isArray(this.filters)) {
                                    //                var $this = this;
                                    //                result.filter += '(';

                                    //                $($this.filters).each(function () {
                                    //                    result.filter += this.field + '~' + this.operator + '~' + "'" + this.value + "'" + '~and~';
                                    //                });

                                    //                // Removing last "~and~".
                                    //                if (result.filter && result.filter.substring(result.filter.length - 5, result.filter.length) == '~and~') {
                                    //                    // Removing last "~and~".
                                    //                    result.filter = result.filter.substring(0, result.filter.length - 5);
                                    //                }
                                    //                result.filter += ')~and~';
                                    //            } else {
                                    //                result.filter += this.field + '~' + this.operator + '~' + "'" + this.value + "'" + '~and~';
                                    //            }
                                    //        });

                                    //        if (result.filter && result.filter.substring(result.filter.length - 5, result.filter.length) == '~and~') {
                                    //            // Removing last "~and~".
                                    //            result.filter = result.filter.substring(0, result.filter.length - 5);
                                    //        }
                                    //    }

                                    //    return result;
                                    //}
                                    //#endregion parameterMap
                                },
                                schema: dataSourceSchema,
                                serverPaging: false,
                                serverFiltering: false,
                                serverSorting: false
                            },
                            //#endregion DataSource

                            selectable: drillDown ? "multiple" : drillDown,
                            detailInit: drillDown ? gridDetailInit : drillDown,
                            detailExpand: function (e) {
                                this.select($(e.masterRow));
                            },
                            detailCollapse: function (e) {
                                $('tr.k-detail-row:hidden').prev('tr.k-master-row.k-state-selected').removeClass('k-state-selected');
                                $(e.masterRow).removeClass('k-state-selected');
                            },
                            pageable: {
                                pageSize: 25,
                                pageSizes: [25, 50, 100]
                            },
                            resizable: true,
                            sortable: {
                                allowUnsort: false
                            },
                            columnResize: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnReorder: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnShow: function(e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnHide: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            scrollable: true,
                            filterable: true,
                            columnMenu: true,
                            columns: columns,
                            dataBound: function (e) {
                                var that = this;
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();

                                // Tooltips initialization
                                if (!TeG.isMobile() && !this.tooltipInitialized) {
                                    // @this = grid
                                    this.thead.kendoTooltip({
                                        filter: "th:not(.k-hierarchy-cell)",
                                        content: function (e) {
                                            var target = e.target; // element for which the tooltip is shown
                                            that.tooltipInitialized = true;
                                            return $(target).text();
                                        }
                                    });
                                }

                                TeG.Reports().LiveGamesFraudCheck().DataBound(e);

                                if ($.isArray(e.sender._data) && e.sender._data.length == 0) {
                                    reportViewModel.titleNoGamePlayData$visible(true);
                                    reportViewModel.titleNoData$visible(false);
                                    TeG.Reports().DisableToolBar();
                                }

                                if ($.isArray(e.sender._data) && e.sender._data.length > 0) {
                                    reportViewModel.titleNoGamePlayData$visible(false);
                                    reportViewModel.titleNoData$visible(false);
                                    TeG.Reports().EnableToolBar();
                                }
                                reportViewModel.reportData$visible(true);

                            },
                        });

                        grid = $('#reportGridData').data('kendoGrid');
                        TeG.Grid.Options.Restore(grid);
                        //#endregion Main grid definition

                        /*Export to Excel*/
                        $('#exportLink').unbind('click').bind('click', function (e) {
                            e.preventDefault();
                            window.open(tegUrlHelper.ExportToExcelLDTransactionsReport + '?' + jQuery.param(requestData) + "&rnd=" + new Date().getTime(), "exportToExcel", "_blank,width=450,height=150,centerscreen,alwaysLowered");
                        });
                        /*End - Export to Excel*/
                    }

                    // Kendo translations
                    $.getScript(location.origin + "/Scripts/kendo/" + kendo.version + "/messages/kendo.messages." + (culturesMap[culture] || 'en-US') + ".min.js", function () {
                        kendo.ui.progress($("#reportGridData"), false);
                        createGrid();
                    });
                },
                //#endregion Submit
                //#region DataBound
                DataBound: function (event) {
                    // restoreColumnsWidthes(event);
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    reportViewModel.summaryData$visible(true);
                    TeG.Reports().Common().DataBoundKO(event);
                }
                //#endregion
            };
        },
        //#endregion

        //#region ProgressiveWinReconcilliatonDetails        
        ProgressiveWinReconcilliatonDetails: function () {   

            var columns = TeG.Reports().Config.ProgressiveWinReconcilliatonDetails.columnsArr;            
            var columnsArrSchema = TeG.Reports().Config.ProgressiveWinReconcilliatonDetails.columnsArrSchema;

            var drillDownColumns = TeG.Reports().Config.ProgressiveWinReconcilliatonDetails.drillDownColumnsArr;
            var drillDownColumnsArrSchema = TeG.Reports().Config.ProgressiveWinReconcilliatonDetails.drillDownColumnsArrSchema;

            function initMemberType() {
                $(columns).each(function (key, value) {
                    if (value.field == 'MasterAgent') {
                        if (TeG.GlobalVariables.memberInfo != undefined && TeG.GlobalVariables.memberInfo.memberTypeId == 1) {
                            columns[key].hidden = false;                            
                        } else {
                            $(document).one('GlobalVariablesMemberInfoReady', initMemberType);
                        }
                    }
                });
            }
            initMemberType();

            function innerGridsCounter() {
                var counter = 0;

                return function () {
                    return ++counter;
                };
            };
            var innerGridOrder = innerGridsCounter();

            function reportGridSummaryDetailInit(e) {
                // @this = grid
                var innerGridOrderValue = innerGridOrder();
                
                $.ajax({
                    url: tegUrlHelper.GetProgressiveWinReconcilliatonDrillDownDetails,
                    type: "POST",
                    data: JSON.stringify({ ProgressiveWinLogId: this.dataItem(e.masterRow).ProgressiveWinLogId }),
                    contentType: "application/json; charset=utf-8",
                    error: function (jqXHR) {
                        tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                        tegErrorHandler.processError(jqXHR);
                    }
                }).done(function (data) {
                    
                        $("<div/>").appendTo(e.detailCell).kendoGrid({
                            dataSource: {
                                data: data,
                                schema: drillDownColumnsArrSchema
                            },
                            pageable: false /*{
                            pageSize: 25,
                            pageSizes: [25, 50, 100]
                        }*/,
                            resizable: true,
                            sortable: {
                                allowUnsort: false
                            },
                            scrollable: true,
                            filterable: true,
                            columnMenu: true,
                            reorderable: true,
                            toolbar: [],
                            columns: drillDownColumns,
                            dataBound: function () {
                                // @this = grid
                                this.element.attr('id', 'reportGridDrillDownData-' + innerGridOrderValue);
                                $("#reportGridData .k-grid-toolbar").html("<h2>" + TeG.Translations.GridJackpotWithdrawalSummaryTitle + "</h2>");
                                $("#reportGridData .k-grid-toolbar").css('text-align', 'left');
                                if (data.length < 1) {
                                    this.element.find('.k-grid-content tbody').append('<tr class="kendo-data-row"><td><div align="center"><h2>' + TeG.Translations.NoData + '</h2></div></td></tr>');
                                }
                                splitterResize();
                               // this.element.find('.k-grid-content').css('height', 'auto');
                               // $('.k-detail-row .k-grid .k-grid-content').css('height', 'auto');
                            },
                            columnResize: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnReorder: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnShow: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnHide: function (e) {
                                TeG.Grid.Options.Store(e);
                            }
                        });

                        TeG.Grid.Options.Restore($('#reportGridDrillDownData-' + innerGridOrderValue).data('kendoGrid'));
                    });
                
            }

            return {
                Show: function () {
                    TeG.Utils().customSelectBehaivor();
                    $(document).on('splitterResizeDone', function (objectEvent) {
                        $('.k-detail-row .k-grid .k-grid-content').css('height', 'auto');
                        $("#reportGridData").find('.k-grid-header:first').css('padding-right', '17px');
                        $("#reportGridData").find('.k-grid-content:first').css('overflow-y', 'scroll');
                    });
                    //#region Print Report
                    /*Print Report*/
                    $('#linkPrint').click(function () {
                        printGrid($("#reportGridData"));
                    });
                    /*End - Print Report*/
                    //#endregion Print Report
                    //#region Global Search
                    /*Global Search*/
                    $(".globalSearchInput ").on("focus", function (e) {
                        $(this).val('');
                    });
                    $(".globalSearchInput ").on("keyup", function (e) {
                        e.preventDefault();

                        $('#cancelSearch').show();
                        if ($.browser.safari && !TeG.isMobile() && !TeG.isIPad()) {
                            $('#cancelSearch').css('left', '170px');
                        }

                        $('#cancelSearch').unbind('click').bind('click', function (event) {

                            var grid = $('#reportGridData').data('kendoGrid');
                            // Refresh filters
                            grid.dataSource.filter({});

                            $(".globalSearchInput ").val('');
                            $('#cancelSearch').hide();
                        });

                        if (e.which == kendo.keys.ENTER) {
                            var filter = { logic: "or", filters: [] };
                            $searchValue = $(this).val();
                            if ($searchValue) {
                                var grid = $('#reportGridData').data('kendoGrid');

                                // applaying filter to each filterable column
                                $(grid.columns).each(function () {

                                    if (this.filterable) {
                                        switch (grid.dataSource.options.schema.model.fields[this.field].type) {
                                            case 'string':
                                        filter.filters.push({ field: this.field, operator: "contains", value: $searchValue });
                                            break;

                                            case 'date':
                                            filter.filters.push({ field: this.field, operator: "eq", value: $searchValue });
                                            break;

                                            case 'number':
                                            filter.filters.push({ field: this.field, operator: "eq", value: parseFloat($searchValue) });
                                            break;
                                    }
                                            
                                    }
                                });
                                grid.dataSource.filter(filter);
                            }
                        }
                    });
                    /*End - Global Search*/
                    //#endregion Global Search

                },

                Submit: function (requestData) {
                    var culturesMap = {
                        //'en': 'en-US',
                        'ch': 'zh-CN',
                        'tw': 'zh-TW',
                    }

                    $('#searchReport').addClass('loading').blur();

                    function createGrid(data) {

                        var gridDataSource = [],
                            gridSummaryDataSource = [];

                        var grid = $('#reportGridData').data('kendoGrid');

                        if (grid != undefined) {
                            grid.destroy();
                            $('#reportGridData').children().remove();
                        }

                        tegPopups.showTotalHover();

                        reportViewModel.searchStart();

                        $(data).each(function (key, value) {
                            var columnsData = {};
                            $.each(columns, function(k, v) {
                                columnsData[v.field] = value[v.field];
                            });
                            gridDataSource.push(columnsData);
                        });

                        if (gridDataSource.length > 10 && reportViewModel.displayRequest() == true && window.isSearchClicked) {
                            TeG.Reports().Common().ExpandCollapse();
                        } else if (gridDataSource.length <= 10 && reportViewModel.displayRequest() == false && window.isSearchClicked) {
                            TeG.Reports().Common().ExpandCollapse();
                        }

                        //#region Main grid definition
                        $('#reportGridData').kendoGrid({
                            dataSource: {
                                data: gridDataSource,
                                schema: columnsArrSchema
                            },
                            columns: columns,
                            selectable: "multiple",
                            pageable: {
                                pageSize: 25,
                                pageSizes: [25, 50, 100]
                            },
                            resizable: true,
                            sortable: {
                                allowUnsort: false
                            },
                            scrollable: true,
                            filterable: true,                            
                            columnMenu: true,
                            reorderable: true,
                            detailInit: reportGridSummaryDetailInit,
                            detailExpand: function (e) {
                                this.select($(e.masterRow));                                     
                            },
                            detailCollapse: function (e) {
                                $('tr.k-detail-row:hidden').prev('tr.k-master-row.k-state-selected').removeClass('k-state-selected');
                                $(e.masterRow).removeClass('k-state-selected');
                            },
                            dataBound: function (e) {
                                var that = this;
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();

                                // Tooltips initialization
                                if (!TeG.isMobile() && !this.tooltipInitialized) {
                                    // @this = grid
                                    this.thead.kendoTooltip({
                                        filter: "th[data-field][data-title!=''][data-role!='droptarget']",
                                        content: function (e) {
                                            var target = e.target; // element for which the tooltip is shown
                                            that.tooltipInitialized = true;
                                            return $(target).text();
                                        }
                                    });
                                }
                                
                                TeG.Reports().ProgressiveWinReconcilliatonDetails().DataBound(e);

                                reportViewModel.reportData$visible(true);
                                reportViewModel.gridData$visible(true);
                                reportViewModel.titleNoData$visible(false);

                                splitterResize();
                               // collapseMenuOnScroll();
                            },

                            columnResize: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnReorder: function (e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnShow: function(e) {
                                TeG.Grid.Options.Store(e);
                            },
                            columnHide: function (e) {
                                TeG.Grid.Options.Store(e);
                            }
                        });
                        var grid = $('#reportGridData').data('kendoGrid');
                        columnObject = [
                            {
                            field: 'MasterAgent', 
                            attr: 'hidden', 
                            value: (TeG.GlobalVariables.memberInfo.memberTypeId == 1) ? false: true, 
                            style: (TeG.GlobalVariables.memberInfo.memberTypeId == 1) ? "" : "display: none",
                            }
                        ];
                        TeG.Grid.Options.Update.Column(grid, columnObject);
                        TeG.Grid.Options.Restore(grid);
                        collapseMenuOnScroll();

                        //Auto expand if one result in grid
                        if (grid.dataSource.data().length == 1) {
                             grid.expandRow(grid.tbody.find("tr.k-master-row"));
                        }
                        //#endregion Main grid definition

                        //#region Export to Excel
                        $('#exportLink').unbind('click').bind('click', function (e) {
                            e.preventDefault();
                            tegPopups.showDaisyWheelTotalHover();
                            
                            var schemaFields = $.extend(columnsArrSchema.model.fields, drillDownColumnsArrSchema.model.fields);

                            var dsSummary = new kendo.data.DataSource({
                                data: $('#reportGridData').data('kendoGrid').dataSource.data(),
                                schema: {
                                    model: {
                                        fields: schemaFields
                                    }
                                }
                            });
                            dsSummary.fetch();

                            var cellTitles = [];

                            $(columns).each(function () {
                                if (!this.hidden && typeof (this.field) != 'undefined') {
                                    cellTitles.push({ value: this.field });                                    
                                }
                                else {
                                    delete (schemaFields[this.field]);
                                }
                            });
                            $(drillDownColumns).each(function () {
                                if (!this.hidden && typeof (this.field) != 'undefined') {
                                    cellTitles.push({ value: this.field });
                                }
                                else {
                                    delete (schemaFields[this.field]);
                                }
                            });
                            
                            var rowsSummary = [{
                                cells: cellTitles
                            }];

                            function populateRecordsForExcelMainGrid(index) {
                                var rowsSummaryCells = [],
                                    sheetsColumns =[];
                                $.each(schemaFields, function (key, value) {
                                     rowsSummaryCells.push({ value: dsSummary.data()[index][key] || '' });
                                });
                                 rowsSummary.push({
                                    cells: rowsSummaryCells
                                });

                                $.ajax({
                                    url: tegUrlHelper.GetProgressiveWinReconcilliatonDrillDownDetails,
                                    type: "POST",
                                    data: JSON.stringify({ ProgressiveWinLogId: data[index].ProgressiveWinLogId }),
                                    contentType: "application/json; charset=utf-8",
                                    error: function (jqXHR) {
                                    }
                                }).done(function (drillDownData) {
                                    if (drillDownData && drillDownData.length > 0) {
                                        $(drillDownData).each(function () {
                                            var that = this;
                                            rowsSummaryCells = [];
                                            sheetsColumns = [];
                                            $.each(schemaFields, function (key, value) {
                                                rowsSummaryCells.push({ value: that[key] || '' });
                                                sheetsColumns.push({ autoWidth: true });
                                            });
                                            
                                            rowsSummary.push({
                                                cells: rowsSummaryCells
                                            });
                                        });
                                    }

                                    if (dsSummary.data()[++index]) {
                                        populateRecordsForExcelMainGrid(index);
                                    } else {
                                        var workbook = new kendo.ooxml.Workbook({
                                            sheets: [
                                            {
                                                columns: sheetsColumns,
                                                // Title of the sheet
                                                title: TeG.Translations.GridPlayersWinsTitle,
                                                // Rows of the sheet
                                                rows: rowsSummary
                                            }
                                            ]
                                        });
                                        tegPopups.closeTotalHover();
                                        //save the file as Excel file with extension xlsx
                                        kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "ProgressiweWinsReconcilliation.xlsx" });
                                    }
                                });
                            }

                            populateRecordsForExcelMainGrid(0);
                           
                        });
                        //#endregion Export to Excel
                    }

                    // Kendo translations
                    $.getScript(location.origin + "/Scripts/kendo/" + kendo.version + "/messages/kendo.messages." + (culturesMap[culture] || 'en-US') + ".min.js", function () {
                        kendo.ui.progress($("#reportGridData"), false);
                        var requestData = reportViewModel.getRequestData();
                        $.ajax({
                            url: tegUrlHelper.GetProgressiveWinReconcilliatonDetails,
                            type: "POST",
                            data: JSON.stringify(requestData),
                            contentType: "application/json; charset=utf-8",
                            error: function (jqXHR) {
                                tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading').blur();
                                tegErrorHandler.processError(jqXHR);
                            }
                        }).done(function (data) {
                            $('#searchReport').removeClass('loading').blur();
                            if (data.length == 0) {
                                reportViewModel.gridData$visible(false);
                                reportViewModel.reportData$visible(true);
                                reportViewModel.titleNoData$visible(true);
                                TeG.Reports().DisableToolBar();
                            } else {
                                createGrid(data);
                            }
                        });
                    });
                },

                DataBound: function (event) {
                    reportViewModel.getSearchParameter().isSummaryReceived = true;
                    TeG.Reports().Common().EndSearch();
                    TeG.Reports().EnableToolBar();                    
                }
            };
        },
        //#endregion

        //#region Common
        Common: function () {
            return {

                StartSearch: function () {
                    // must be global scope
                    window.searchReportFlow = { isSummaryReceive: false, isSummaryEmpty: false, isDataBound: false, isDataEmpty: false, isEventSourceSearchButton: true, isReportDataVisible: true }
                },

                EndSearch: function () {
                    delete searchReportFlow;
                },

                /*
                 *  Used by DataBound and DataBoundKO functions
                 */
                DataBoundBase: function (event) {
                    var grid = $(event.sender.element).data('kendoGrid');

                    // Sets tooltips on columns headers
                    function setGridHeaderTooltips() {
                        if ($(grid.element).find("[data-role=tooltip]").length > 0 && $(grid.element).find("[data-role=tooltip]").data('kendoTooltip')) {
                            $(grid.element).find("[data-role=tooltip]").data('kendoTooltip').destroy();
                        }

                        grid.thead.kendoTooltip({
                            filter: "th[data-field][data-title!=''][data-role!='droptarget']",
                            content: function (e) {
                                var target = e.target; // element for which the tooltip is shown
                                return $(target).text();
                            }
                        });
                    }

                    setGridHeaderTooltips();
                },

                DataBound: function (event) {
                    this.DataBoundBase(event);

                    if (typeof (searchReportFlow) != 'undefined' && searchReportFlow.isEventSourceSearchButton) {
                        searchReportFlow.isDataBound = true;
                        if (event && event.sender.dataSource.data().length == 0) {
                            searchReportFlow.isDataEmpty = true;
                        } else {
                            searchReportFlow.isDataEmpty = false;
                        }
                    }
                    TeG.Reports().Common().ShowReport();
                    (new TeG.Grid(event.sender)).markFilter(); // looks like a trick, because I'm not shure that event.sender == grid (like polymorf in this case)
                    /*
                    $('table[role=grid]').find("span").removeClass("filtering_funnel").addClass("k-icon").addClass("k-i-arrowhead-s");

                    var filter = event.sender.dataSource.filter();
                    if (filter) {
                        for (elem in filter.filters) {
                            $('[data-field="' + filter.filters[elem].field + '"]').find("span").removeClass("k-icon").removeClass("k-i-arrowhead-s").addClass("filtering_funnel");
                        }
                    }
                    */
                    if (event.sender._data.length == 0) {
                        window.isEmptyGrid = true;
                    }
                    // collapse expand Search Criteria
                    if (event.sender._data.length > 10 && $('#collapseBehaivor').is(':visible') && window.isSearchClicked) {
                        TeG.Reports().Common().ExpandCollapse();
                    } else if (event.sender._data.length <= 10 && $('#expandBehaivor').is(':visible') && window.isSearchClicked) {
                        TeG.Reports().Common().ExpandCollapse();
                    }
                    //                    $('#reportData').show();
                },

                DataBoundKO: function (event) {

                    this.DataBoundBase(event);

                    reportViewModel.getSearchParameter().isDataReceived = true;
                    reportViewModel.getSearchParameter().isSummaryReceived = true; // fake, needed for eportViewModel.gridShow()
                    reportViewModel.getSearchParameter().row = event.sender.dataSource.data().length;
                    if (reportViewModel.getSearchParameter().row > 0) {
                        reportViewModel.gridData$visible(true);
                        reportViewModel.summaryData$visible(true);
                    }
                    reportViewModel.gridShow();
                    setTimeout(splitterResize, 0);
                    collapseMenuOnScroll();
                },

                ShowReport: function () {
                    if (typeof (searchReportFlow) != 'undefined' && searchReportFlow.isEventSourceSearchButton) {
                        if ((searchReportFlow.isSummaryReceive && searchReportFlow.isSummaryEmpty)
                            || (searchReportFlow.isReportDataVisible && searchReportFlow.isDataBound && searchReportFlow.isDataEmpty)) {
                            $('#reportData').show();
                            $('#reportDataTitleSummary').hide();
                            $('#reportInterval').hide();
                            $('#reportDataTitleNoData').show();
                            $('#reportSummaryDataMultiCurrency').hide();
                            $('#reportGridData').hide();
                            $('#reportSummaryData').hide();
                            tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading');
                            TeG.Reports().Common().EndSearch();
                            TeG.Reports().DisableToolBar();
                        } else if ((searchReportFlow.isSummaryReceive && !searchReportFlow.isSummaryEmpty)
                            && (!searchReportFlow.isReportDataVisible || searchReportFlow.isDataBound && !searchReportFlow.isDataEmpty)) {
                            $('#reportData').show();
                            $('#reportDataTitleSummary').show();
                            $('#reportInterval').show();
                            $('#reportDataTitleNoData').hide();
                            $('#reportSummaryDataMultiCurrency').show();
                            $('#reportSummaryData').show();
                            if (($('#casino-earning-here').length !== 0 || $('#cashier-here').length !== 0)) {
                                if ($('select[name="fromDateHour"]').css('display') == 'inline-block') {
                                    var nFromDate = TeG.Utils().formatDateTime($('input[name="fromDate"]').val(), $('select[name="fromDateHour"]').val(), $('select[name="fromDateMinute"]').val());
                                    var nToDate = TeG.Utils().formatDateTime($('input[name="toDate"]').val(), $('select[name="toDateHour"]').val(), $('select[name="toDateMinute"]').val());
                                } else {
                                    var nFromDate = TeG.Utils().formatDateTime($('input[name="fromDate"]').val(), '00', '00');
                                    var nToDate = TeG.Utils().formatDateTime($('input[name="toDate"]').val(), '23', '59');
                                }
                                $('#reportInterval').html(nFromDate + ' - ' + nToDate);
                            } else {
                                $('#reportInterval').html($('input[name="fromDate"]').val() + ' - ' + $('input[name="toDate"]').val());
                            }
                            if (searchReportFlow.isReportDataVisible) {
                                $('#reportGridData').show();
                            } else {
                                $('#reportGridData').hide();
                            }
                            tegPopups.closeTotalHover(); $('#searchReport').removeClass('loading');
                            TeG.Reports().Common().EndSearch();
                            if (typeof (gridManager) != 'undefined') {
                                TeG.Utils().searchBehaivor($('#GlobalSearchEdit'), gridManager.RefreshGrid);
                            }
                            TeG.Reports().EnableToolBar();
                            splitterResize();
                            collapseMenuOnScroll();
                        }
                    }
                },
                ValidateDateInput: function (inputId) {
                    var dateListener = null;

                    if ($('input[name="timeGrouping"]:checked').length > 0) {
                        dateListener = ($('input[name="timeGrouping"]:checked').val() === 'Month') ? 'ShortDateIncorrectListener' : 'FullDateIncorrectListener';
                    }
                    
                    if ($('select[name="groupingType"]').length > 0 && $('select[name="groupingType"]').val() && ($('select[name="groupingType"]').val().toLowerCase() === 'month' || $('select[name="groupingType"]').val().toLowerCase() === 'day')) {
                        dateListener = $('select[name="groupingType"]').val().toLowerCase() === 'month' ? 'ShortDateIncorrectListener' : 'FullDateIncorrectListener';
                    }

                    dateListener = dateListener || 'FullDateIncorrectListener';

                    //groupingType
                    var input = $('#' + inputId);
                    (new TeG.Validator(input)).CleanAllError(input);
                    (new TeG.Validator(input))
                        .RequiredListener(TeG.Translations.ReportDateEmpty)[dateListener](TeG.Translations.ReportDateEmpty)
                        .OnlyDigitsAndHyphensListener((TeG.Translations.ValidateInsertFieldInCorrectFormat
                                .replace(/%%field_label%%/, $('label[for="' + inputId + '"]').html().replace(/^\s*|\:|\s*$/g, ''))))
                        .DateInvalidListener(TeG.Translations.ReportDateEmpty)
                        .FromDatePrecedesListener(TeG.Translations.ErrorMessageStartDateMustPrecedeEndDate)
                        .DisplayErrorMessageOffsetTop(3)
                        .ErrorRenderDefault();
                },
                // parameter data not used in method
                ValidateData: function (data, elem) {
                    if (!elem) {
                        elem = $('#fromDate');
                    }

                    TeG.Reports().Common().ValidateDateInput('fromDate');
                    TeG.Reports().Common().ValidateDateInput('toDate');

                    if ((new TeG.Validator()).IsContainerHasDisplayedErrorMessage($('#report'))) return false;

                    var fromDateArr = $('#fromDate').val().split('-');
                    if (fromDateArr.length == 2) {
                        fromDateArr = [1].concat(fromDateArr);
                    }
                    if ($('select[name="fromDateHour"]').index() != -1 && ($('select[name="fromDateHour"]').is(':visible'))
                            && $('select[name="fromDateMinute"]').index() != -1 && $('select[name="fromDateMinute"]').is(':visible')) {
                        fromDateArr = fromDateArr.concat([$('select[name="fromDateHour"]').val(), $('select[name="fromDateMinute"]').val()]);
                    } else {
                        fromDateArr = fromDateArr.concat([0, 0]);
                    }
                    var fromDate = new Date(fromDateArr[2], fromDateArr[1] - 1, fromDateArr[0], fromDateArr[3], fromDateArr[4]);
                    var toDateArr = $('#toDate').val().split('-');
                    if (toDateArr.length == 2) {
                        toDateArr = [1].concat([toDateArr]);
                    }
                    if ($('select[name="toDateHour"]').index() != -1 && ($('select[name="toDateHour"]').is(':visible'))
                            && $('select[name="toDateMinute"]').index() != -1 && $('select[name="toDateMinute"]').is(':visible')) {
                        toDateArr = toDateArr.concat([$('select[name="toDateHour"]').val(), $('select[name="toDateMinute"]').val()]);
                    } else {
                        toDateArr = toDateArr.concat([0, 0]);
                    }
                    var toDate = new Date(toDateArr[2], toDateArr[1] - 1, toDateArr[0], toDateArr[3], toDateArr[4]);

                    if (fromDate > toDate) {
                        (new TeG.Validator(elem)).SetMessage(TeG.Translations.ErrorMessageStartDateMustPrecedeEndDate).DisplayErrorMessageOffsetTop(3).ErrorRenderDefault();
                        return false;
                    } else {
                        (new TeG.Validator()).CleanError(elem);
                    }
                    return true;
                },

                ExpandCollapse: function () {
                    Window.isSearchClicked = false;

                    if ($('#expandSearchCriteria').is(':visible')) {
                        $('#expandSearch').find('span').hide();
                    } else {
                        $('#collapseBehaivor').hide();
                    }
                    $('#reportrequire').toggle('slow', function () {
                        if ($('#reportrequire').is(':visible')) {
                            $('#collapseBehaivor').show();
                        } else {
                            $('#expandSearch').find('span').show();
                        }
                        resizeGrid();

                        if ($('#reportHeaderContainer').hasClass('collapsed')) {
                            $('#reportHeaderContainer').removeClass('collapsed');
                        } else {
                            $('#reportHeaderContainer').addClass('collapsed');
                        }
                    });
                },

                ColumnReorder: function (event) {
                    if (event.newIndex == 0 || event.oldIndex == 0/* && typeof(TeG.ReportReorderColumn) == 'undefined'*/) {
                        setTimeout(function () {
                            event.sender.reorderColumn(event.oldIndex, event.sender.columns[event.newIndex])
                        }, 100)
                    }
                },

                columnShow: function (event, field) {
                    setTimeout(function () {
                        $('input[type="checkbox"][data-field="' + field + '"]').attr('disabled', 'disabled');
                    });
                    splitterResize();
                },

                ColumnHide: function (event, field) {
                    setTimeout(function () {
                        $('input[type="checkbox"][data-field="' + field + '"]').attr('disabled', 'disabled');
                    });
                    if (event.column.field == field) {
                        event.sender.showColumn(0);
                    }
                    splitterResize();
                },

                ColumnMenuInit: function (event, field) {
                    $('input[type="checkbox"][data-field="' + field + '"]').attr('disabled', 'disabled');
                },

                getImageGroupCollapse: function () {
                    return '<div class="arrow-right"></div>&nbsp;';
                },

                getImageGroupExpand: function () {
                    return '<div class="arrow-down"></div>&nbsp;';
                },

                ClearAllBefore: function () {
                    $('#reportGridTitleNoData').hide();
                    $('#reportData').hide();
                    $('#reportSummaryData').html('');
                    $('#reportGridData').html('');
                    tegPopups.showTotalHover();
                    $('#searchReport').addClass('loading');
                },

                // List of icon types. All the new added elements need to be in lower case only.
                IconTypes: function () {
                    return {
                        station: 'station transaction',
                        player: 'player transaction',
                        agent: 'agent transaction',
                        masterAgent: 'master agent transaction',
                        administrator: 'administrator transaction',
                        headOffice: 'head office transaction',
                        dailyContribution: 'daily contribution'
                    };
                },

                // Hash of Status icons
                IconsStatuses: {
                    open: "<div style='text-align:center'><img alt='Open' src='/Images/statusOpen.png'></div>",
                    lock: "<div style='text-align:center'><img alt='Lock' src='/Images/statusLocked.png'></div>",
                    suspend: "<div style='text-align:center'><img alt='Suspend' src='/Images/statusSuspended.png'></div>",
                    networklock: "<div style='text-align:center'><img alt='NetworkLock' src='/Images/statusNetworkLocked.png'></div>",
                    networksuspend: "<div style='text-align:center'><img alt='NetworkSuspend' src='/Images/statusSuspended.png'></div>",
                    networklockforsuspend: "<div style='text-align:center'><img alt='NetworkLockForSuspend' src='/Images/statusNetworkLocked.png'></div>"
                },

                /**
                 * function to replace text in grid columns by icons
                 * @param columnName
                 * @param gridDataSource - optional param
                 */
                ReplaceTypesByIcons: function (columnName, gridDataSource) {
                    var typesList = TeG.Reports().Common().IconTypes();
                    if (!gridDataSource) {
                        gridDataSource = TeG.Reports.grid1.grid.dataSource;
                    }
                    var columnNumber = $('th[data-field="' + columnName + '"]').index();
                    var tdClass = $('.k-grid-content tr').find('td').eq(columnNumber).attr('class'); //HACK - further operations are performing by class, not by index
                    $.each($('.' + tdClass), function (key, value) {
                        var typeText = $.trim($(value).html().toLowerCase());
                        var iconFileTag = '';
                        switch (typeText) {
                            case typesList.station:
                                iconFileTag = '<img src = "/Images/icStation.png" data-transactionType="StationTransaction" title="' + TeG.Translations.ReportOptionStationTransaction + '">';
                                break;
                            case typesList.player:
                                iconFileTag = '<img src = "/Images/icPlayer.png" data-transactionType="PlayerTransaction" title="' + TeG.Translations.ReportOptionPlayerTransaction + '">';
                                break;
                            case typesList.agent:
                                iconFileTag = '<img src = "/Images/icAgent.png" data-transactionType="AgentTransaction" title="' + TeG.Translations.ReportOptionAgentTransaction + '">';
                                break;
                            case typesList.masterAgent:
                                iconFileTag = '<img src = "/Images/icMasterAgent.png" data-transactionType="MasterAgentTransaction" title="' + TeG.Translations.ReportOptionMasterAgentTransaction + '">';
                                break;
                            case typesList.administrator:
                                iconFileTag = '<img src = "/Images/icAdministrator.png" data-transactionType="AdministratorTransaction" title="' + TeG.Translations.ReportOptionAdministratorTransaction + '" />';
                                break;
                            case typesList.headOffice:
                                iconFileTag = '<img src = "/Images/icHeadOffice.png" data-transactionType="HeadOfficetransaction" title="' + TeG.Translations.ReportOptionHeadOfficeTransaction + '" />';
                                break;
                            case typesList.dailyContribution:
                                iconFileTag = '<img src = "/Images/icDailyContribution.png" data-transactionType="DailyContribution" title="' + TeG.Translations.ReportOptionDailyContribution + '" />';
                                break;
                            default:
                                iconFileTag = 'No icon';
                        }
                        $(value).html(iconFileTag);
                        gridDataSource._data[key][columnName] = iconFileTag;
                    });
                    delete typesList;
                }
            }
        }
        //#endregion
    }
};
;
