import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './layout/header/header.component';
import { FooterComponent } from './layout/footer/footer.component';
import { HomeComponent } from './pages/home/home.component';
import { RegionsComponent } from './pages/regions/regions.component';
import { HttpClientModule } from '@angular/common/http';
import { AppConfigModule } from './app-config.module';
import { CountriesComponent } from './pages/countries/countries.component';
import { LocationsComponent } from './pages/locations/locations.component';
import { DepartmentsComponent } from './pages/departments/departments.component';
import { DependentsComponent } from './pages/dependents/dependents.component';
import { JobsComponent } from './pages/jobs/jobs.component';
import { EmployeesComponent } from './pages/employees/employees.component';
import { DataTablesModule } from 'angular-datatables';
import * as $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs4';
import { EmployeeFormComponent } from './pages/employee-form/employee-form.component';
import { FormsModule } from '@angular/forms';
import { ToastrModule } from 'ngx-toastr';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    FooterComponent,
    HomeComponent,
    RegionsComponent,
    CountriesComponent,
    LocationsComponent,
    DepartmentsComponent,
    DependentsComponent,
    JobsComponent,
    EmployeesComponent,
    EmployeeFormComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    AppConfigModule,
    DataTablesModule,
    FormsModule,
    ToastrModule.forRoot(),
    BrowserAnimationsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
