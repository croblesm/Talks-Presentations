import { Component, OnInit } from '@angular/core';
import { Locations } from 'src/app/core/models/locations';
import { LocationsService } from 'src/app/core/services/locations.service';

@Component({
  selector: 'app-locations',
  templateUrl: './locations.component.html',
  styleUrls: ['./locations.component.scss']
})
export class LocationsComponent implements OnInit {
  public items: Locations[];
  constructor(public service:LocationsService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}
