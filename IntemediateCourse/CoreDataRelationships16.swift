//
//  CoreDataRelationships16.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 26.03.2024.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    
    static let instance = CoreDataManager() // singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "CoreDataContainer")
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data. \(error)")
            }
        }
        self.context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving core data. \(error)")
        }
        
    }
    
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching request. \(error)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching request. \(error)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching request. \(error)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Amazon"
        //businesses.append(newBusiness)
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finanace"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2], businesses[3]]
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Hasan Kemal Turj"
        newEmployee.age = 23
        newEmployee.dateJoined = Date.now
        //newEmployee.business = businesses[0]
        //newEmployee.department = departments[0]
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
        
    }
    
    
    
    
}

struct CoreDataRelationships16: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.addBusiness()
                    } label: {
                        Text("Add Business")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    Button {
                        vm.addDepartment()
                    } label: {
                        Text("Add Department")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    Button {
                        vm.addEmployee()
                    } label: {
                        Text("Add Employee")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    
                    ScrollView (.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                        
                    }
                    
                    ScrollView (.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                        
                    }
                    
                    ScrollView (.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                        
                    }
                    
                }
                .navigationTitle("Relationships")
            }
        }
    }
}





struct CoreDataRelationships16_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationships16()
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .font(.headline)
                .fontWeight(.bold)
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
            
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .font(.headline)
                .fontWeight(.bold)
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
            
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}



struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Age: \(entity.age)")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Date Joined: \(entity.dateJoined ?? Date())")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Business: ")
            Text(entity.business?.name ?? "")
            
            Text("Department: ")
            Text(entity.department?.name ?? "")
            
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.purple.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
