@Model model
$(function () {
    ko.applyBindings(IndexVM);
    IndexVM.getEmployees();
});

var IndexVM = {
    Employees: ko.observableArray([]),
    getEmployees: function () {
        var self = this;
        //$.ajax({
        //    type: "GET",
        //    url: '/Employee/Index',
        //    contentType: "application/json; charset=utf-8",
        //    dataType: "json",
        //    success: function (data) {
        //        console.log(data);
        //        self.Employees(data); //Put the response in ObservableArray
        //    },
        //    error: function (err) {
        //        alert(err.status + " : " + err.statusText);
        //    }
        //});
    },
    CreateNew: function () {
        window.location.href = '/Employee/Create';
    },
    Back: function(){
        window.location.href = '/Home';
    }
};

self.EditEmployee = function (employee) {
    window.location.href = '/Employee/Edit/' + employee.EmployeeID;
};
self.DeleteEmployee = function (employee) {
    window.location.href = '/Employee/Delete/' + employee.EmployeeID;
};

//Model
function Employees(data) {
    console.log(data);
    this.EmployeeID = ko.observable(data.EmployeeID);
    this.FirstName = ko.observable(data.FirstName);
    this.LastName = ko.observable(data.LastName);
    this.JoiningDate = ko.observable(data.JoiningDate);
}