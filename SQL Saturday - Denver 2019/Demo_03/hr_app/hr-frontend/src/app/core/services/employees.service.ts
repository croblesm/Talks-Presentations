import { Injectable, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AppConfig, APP_CONFIG } from 'src/app/app-config.module';
import { Observable } from 'rxjs';
import { Employees } from '../models/employees';


@Injectable({
  providedIn: 'root'
})
export class EmployeesService {
  constructor(private httpClient: HttpClient,@Inject(APP_CONFIG)  public config:AppConfig) { }

  public getAll(): Observable<any>{
    return this.httpClient.get<any>(`${this.config.apiEndpoint}/employees/`);
  }

  public get(id: number): Observable<Employees>{
    return this.httpClient.get<Employees>(`${this.config.apiEndpoint}/employees/${id}`);
  }

  save(item: Employees): Observable<Employees> {
    return this.httpClient.post<Employees>(`${this.config.apiEndpoint}/employees/` ,item);
  }
  
  delete(id: number): Observable<any> {
    return this.httpClient.delete(`${this.config.apiEndpoint}/employees/${id}`);
  }
  
  update(id:number, item: Employees): Observable<Employees> {
    return this.httpClient.put<Employees>(`${this.config.apiEndpoint}/employees/${id}`,item);
  }
}