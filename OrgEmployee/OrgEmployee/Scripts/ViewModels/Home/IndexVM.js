$(function () {
    ko.applyBindings(IndexVM);
});

var IndexVM = {
    viewEmployeeList: function () {
        window.location.href = '/Employee/Index';
    },
    viewEnrollmentList: function () {
        window.location.href = '/Enrollment/Index';
    }
};
