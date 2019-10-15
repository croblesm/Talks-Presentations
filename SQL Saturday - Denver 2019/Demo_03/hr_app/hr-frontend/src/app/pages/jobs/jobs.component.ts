import { Component, OnInit } from '@angular/core';
import { Jobs } from 'src/app/core/models/jobs';
import { JobsService } from 'src/app/core/services/jobs.service';

@Component({
  selector: 'app-jobs',
  templateUrl: './jobs.component.html',
  styleUrls: ['./jobs.component.scss']
})
export class JobsComponent implements OnInit {
  public items: Jobs[];
  constructor(public service:JobsService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}