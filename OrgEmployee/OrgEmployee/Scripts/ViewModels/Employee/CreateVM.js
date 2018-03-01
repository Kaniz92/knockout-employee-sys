$(function () {
    ko.applyBindings(CreateVM);
});

var CreateVM = {
    LastName: ko.observable(),
    FirstName: ko.observable(),
    JoiningDate: ko.observable(new Date()),

    SaveEmployee: function () {
        $.ajax({
            url: '/Employee/Create',
            type: 'post',
            dataType: 'json',
            data: ko.toJSON(this),
            contentType: 'application/json',
            success: function (result) {
            },
            error: function (err) {
                console.log('Error: ' + err);
            },
            complete: function () {
                window.location.href = '/Employee/Index';
            }
        });
    }

};