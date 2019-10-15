import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { RegionsComponent } from './pages/regions/regions.component';
import { CountriesComponent } from './pages/countries/countries.component';
import { LocationsComponent } from './pages/locations/locations.component';
import { DepartmentsComponent } from './pages/departments/departments.component';
import { DependentsComponent } from './pages/dependents/dependents.component';
import { JobsComponent } from './pages/jobs/jobs.component';
import { EmployeesComponent } from './pages/employees/employees.component';
import { EmployeeFormComponent } from './pages/employee-form/employee-form.component';


const routes: Routes = [
  {
    path: '',
    pathMatch: 'full',
    component: HomeComponent
  },
  {
    path: 'regions',
    component: RegionsComponent
  },
  {
    path: 'countries',
    component: CountriesComponent
  },
  {
    path: 'locations',
    component: LocationsComponent
  },
  {
    path: 'departments',
    component: DepartmentsComponent
  },
  {
    path: 'dependents',
    component: DependentsComponent,
  },
  {
    path: 'jobs',
    component: JobsComponent,
  },
  {
    path: 'employees',
    component: EmployeesComponent,
  },
  { path: 'employee/new', component: EmployeeFormComponent },
  { path: 'employee/:id', component: EmployeeFormComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
