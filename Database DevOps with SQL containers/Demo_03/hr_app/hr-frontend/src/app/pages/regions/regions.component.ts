import { Component, OnInit } from '@angular/core';
import { RegionsService } from 'src/app/core/services/regions.service';
import { Regions } from 'src/app/core/models/regions';

@Component({
  selector: 'app-regions',
  templateUrl: './regions.component.html',
  styleUrls: ['./regions.component.scss']
})
export class RegionsComponent implements OnInit {
  public items: Regions[];

  constructor(public service:RegionsService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}
