import { Component, OnInit } from '@angular/core';
import { Departments } from 'src/app/core/models/departments';
import { DepartmentsService } from 'src/app/core/services/departments.service';

@Component({
  selector: 'app-departments',
  templateUrl: './departments.component.html',
  styleUrls: ['./departments.component.scss']
})
export class DepartmentsComponent implements OnInit {
  public items: Departments[];
  constructor(public service:DepartmentsService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}