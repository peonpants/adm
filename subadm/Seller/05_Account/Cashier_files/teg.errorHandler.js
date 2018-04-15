var TeG = TeG || {};

function checkAuth(jqXHR) {
    var contentType = jqXHR.getResponseHeader("Content-Type");
    if (jqXHR.status === 200 && contentType.toLowerCase().indexOf("text/html") >= 0) {
        redirectToLoginPage();
        return false;
    }

    return true;
}

function redirectToLoginPage() { // TODO: move to route helper
    window.location = tegUrlHelper.Login;  //'/' + culture + '/Account/Login';
}

function getErrorTranslation(exceptionName) {
    if (TeG.Errors[exceptionName] != null) {
        return TeG.Errors[exceptionName];
    }

    return TeG.Errors["GeneralError"];
}



TeG.ErrorHandler = (function () {

    function getErrorMessage(error) {

        var key= String.format('{0}_{1}_{2}', error.ControllerName, error.ActionName, error.ErrorReason);
        //console.log(translationKey);
        var errorMessage = TeG.TranslatedErrors[key];

        if (errorMessage != undefined) {
            return errorMessage;
        } else {
            return getErrorTranslation(error.ExceptionName || null) + " " + error.ReferenceNumber;
        }
    }

    return {
        checkAjaxResponse: function (jqXHR) {
            if (!checkAuth(jqXHR)) {
                return false;
            }

            return true;
        },

        processError: function (jqXHR, popupHeader, closeHandler) {
            if (!popupHeader) {
                popupHeader = TeG.Translations.PopupError;
            }
            var error = $.parseJSON(jqXHR.responseText);

            if (error && error.ExceptionMessage && error.ExceptionMessage.indexOf("INPUTPROFILEISWRONG") === 0) {
                error.ExceptionName = error.ExceptionMessage;
            }
            if (error && error.ExceptionMessage && error.ExceptionMessage.indexOf("LOGINISNOTLOGGEDIN") === 0) {
                redirectToLoginPage();
                return;
            }
            if (typeof(error.isNeedTranslation) == 'undefined') {
                //TeG.Popups(true).error(closeHandler).show(popupHeader, getErrorTranslation(error.ExceptionName) + " " + error.ReferenceNumber);
                TeG.Popups(true).error(closeHandler).show(popupHeader, getErrorMessage(error));
            } else if (typeof(error.isNeedTranslation) != 'undefined' && !error.isNeedTranslation) {
                TeG.Popups(true).error(closeHandler).show(popupHeader, error.ExceptionName);
            }
        }
    };
});

tegErrorHandler = new TeG.ErrorHandler();

