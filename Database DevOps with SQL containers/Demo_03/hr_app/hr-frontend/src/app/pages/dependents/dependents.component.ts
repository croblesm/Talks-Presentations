import { Component, OnInit } from '@angular/core';
import { Dependents } from 'src/app/core/models/dependents';
import { DependentsService } from 'src/app/core/services/dependents.service';

@Component({
  selector: 'app-dependents',
  templateUrl: './dependents.component.html',
  styleUrls: ['./dependents.component.scss']
})
export class DependentsComponent implements OnInit {
  public items: Dependents[];
  constructor(public service:DependentsService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}