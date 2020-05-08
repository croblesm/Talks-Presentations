import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HomeComponent } from './home/home.component';
import { RegionsComponent } from './regions/regions.component';
import { CountriesComponent } from './countries/countries.component';
import { DepartmentsComponent } from './departments/departments.component';
import { DependentsComponent } from './dependents/dependents.component';
import { EmployeesComponent } from './employees/employees.component';
import { JobsComponent } from './jobs/jobs.component';
import { LocationsComponent } from './locations/locations.component';
import { EmployeeFormComponent } from './employee-form/employee-form.component';



@NgModule({
  declarations: [HomeComponent, RegionsComponent, CountriesComponent, DepartmentsComponent, DependentsComponent, EmployeesComponent, JobsComponent, LocationsComponent, EmployeeFormComponent],
  imports: [
    CommonModule
  ]
})
export class PagesModule { }
