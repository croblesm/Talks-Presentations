import { Injectable, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { APP_CONFIG, AppConfig } from 'src/app/app-config.module';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DepartmentsService {

  constructor(private httpClient: HttpClient,@Inject(APP_CONFIG)  public config:AppConfig) { }

  public getAll(): Observable<any>{
    return this.httpClient.get<any>(`${this.config.apiEndpoint}/departments/`);
  }
}