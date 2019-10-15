import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { EmployeesService } from 'src/app/core/services/employees.service';
import { Employees } from 'src/app/core/models/employees';
import { ToastrService } from 'ngx-toastr';
import { DepartmentsService } from 'src/app/core/services/departments.service';
import { JobsService } from 'src/app/core/services/jobs.service';
import { Departments } from 'src/app/core/models/departments';
import { Jobs } from 'src/app/core/models/jobs';

@Component({
  selector: 'app-employee-form',
  templateUrl: './employee-form.component.html',
  styleUrls: ['./employee-form.component.scss']
})
export class EmployeeFormComponent implements OnInit {

  public item:Employees = new Employees;
  lstDepartment:Departments[] = [];
  lstJobs:Jobs[] = [];
  lstManager:Employees[] = [];
  hireDate;

  constructor(private route: ActivatedRoute,
    private router: Router,
    private service: EmployeesService,
    private srvToaster: ToastrService,
    private srvDepartment:DepartmentsService,
    private srvJob:JobsService,
    ) { 
      route.params.subscribe(p => {
        if (p['id'] == undefined){
          this.item = new Employees;
          let today = new Date();
          this.hireDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        }else{
          this.getRegister(p['id']);
        }
      }, err => {
        if(err.status == 404)
          this.router.navigate(['/employees']);
      });

      srvDepartment.getAll().subscribe(items=>{
        this.lstDepartment = items;
      });

      srvJob.getAll().subscribe(items=>{
        this.lstJobs = items;
      });

      service.getAll().subscribe(items=>{
        this.lstManager = items;
      });
      
    }

  ngOnInit() {
  }

  getRegister(id:number){
    this.service.get(id)
      .subscribe(b => {
          this.item = b;
          this.hireDate = this.parseDate(this.item.hire_date);
      });
  }

  submit(){
    this.item.hire_date = this.hireDate;
    this.item.department_id = parseInt(""+this.item.department_id);
    this.item.job_id = parseInt(""+this.item.job_id);
    if (this.item.manager_id != null){
      this.item.manager_id = parseInt(""+this.item.manager_id);
    }
    
    if(this.item.employee_id != 0)
    {
      this.service.update(this.item.employee_id, this.item)
        .subscribe( response => 
          {
            this.srvToaster.success("Successfully created!");
            this.router.navigate(['/employees']);
          },
          error=>{
            this.srvToaster.error("Error saving record, try again.");
          });
    }
    else{
      this.service.save(this.item)
        .subscribe( 
          response => 
          {
            this.srvToaster.success("Successfully updated!");
            this.router.navigate(['/employees'])
          },
          error =>{
            this.srvToaster.error("Error updating record, try again.");
          });
    }
  }

  delete(){
    if(confirm("Are you sure?")){
      this.service.delete(this.item.employee_id)
        .subscribe(x => {
          this.srvToaster.success("Successfully deleted!");
          this.router.navigate(['/employees']);
        });
    }
  }

  parseDate(value: any): string {
    var raw = value.split("-");
    var raw2 = raw[2].split("T");
    var fecha = raw[0] + "-" + raw[1] + "-"+raw2[0];
    return fecha;
  }
}
