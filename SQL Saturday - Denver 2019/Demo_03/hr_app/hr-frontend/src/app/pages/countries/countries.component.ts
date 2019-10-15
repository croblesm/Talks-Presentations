import { Component, OnInit } from '@angular/core';
import { Countries } from 'src/app/core/models/countries';
import { CountriesService } from 'src/app/core/services/countries.service';

@Component({
  selector: 'app-countries',
  templateUrl: './countries.component.html',
  styleUrls: ['./countries.component.scss']
})
export class CountriesComponent implements OnInit {
  public items: Countries[];
  constructor(public service:CountriesService) { }

  ngOnInit() {
    this.service.getAll().subscribe(
      items =>{
        this.items = items;
      }
    );
  }

}
