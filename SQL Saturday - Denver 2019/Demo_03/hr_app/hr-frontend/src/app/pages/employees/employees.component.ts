import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { Employees } from 'src/app/core/models/employees';
import { EmployeesService } from 'src/app/core/services/employees.service';
import { Subject } from 'rxjs';
import * as $ from 'jquery';
import 'datatables.net';
import 'datatables.net-bs4';

@Component({
  selector: 'app-employees',
  templateUrl: './employees.component.html',
  styleUrls: ['./employees.component.scss']
})
export class EmployeesComponent implements OnInit {
  dataTable: any;
  public dtOptions: DataTables.Settings = {};
  public dtTrigger: Subject<any> = new Subject();

  public items: any[] = [];
  constructor(public service:EmployeesService, private chRef: ChangeDetectorRef) { }

  ngOnInit() {
    this.dtOptions = {
      pagingType: 'full_numbers',
      pageLength: 2
    };

    this.service.getAll().subscribe(
      items =>{
        this.items = items;

        this.chRef.detectChanges();

        const table: any = $('table');
        this.dataTable = table.DataTable();
      }
    );
  }

}