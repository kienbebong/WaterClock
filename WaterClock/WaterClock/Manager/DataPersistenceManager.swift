//
//  DataPersistenceManager.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 12/11/24.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func downloadAccount(accountLogin: Account, completion: (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        
        let account = AccountEntity(context: context)
        
        account.userId = accountLogin.USER_ID
        account.code = accountLogin.CODE
        account.lastActiveTime = accountLogin.LASTACTIVE_TIME
        account.message = accountLogin.MESSAGE
        account.roleName = accountLogin.ROLE_NAME
        account.token = accountLogin.TOKEN
        account.tokenExpired = accountLogin.TOKEN_EXPIRED
        account.userAccount = accountLogin.USER_ACCOUNT
        account.userAddress = accountLogin.USER_ADDRESS
        account.userEmail = accountLogin.USER_EMAIL
        account.userName = accountLogin.USER_NAME
        account.userTel = accountLogin.USER_TEL
        account.userType = accountLogin.USER_TYPE
        
        do {
            try context.save()
            let savedAccount = try context.fetch(fetchRequest)
                   
            if let savedAccount = savedAccount.first {
                print("Account saved successfully:")
                print("User ID: \(savedAccount.userId ?? "N/A")")
                print("User Account: \(savedAccount.userAccount ?? "N/A")")
                print("User Name: \(savedAccount.userName ?? "N/A")")
                print("Role Name: \(savedAccount.roleName ?? "N/A")")
                print("Token: \(savedAccount.token ?? "N/A")")
            }
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchAccount(completion: @escaping (Result<AccountEntity, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let accounts = try context.fetch(request)
            if let account = accounts.first{
                completion(.success(account))
            } else {
                print("khong co thong tin tai khoan")
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteAccount(accountLogin: AccountEntity, completion: (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(accountLogin)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteAllAccounts(completion: (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        
        do {
            let accounts = try context.fetch(fetchRequest)
            
            for account in accounts {
                context.delete(account)
            }
            
            try context.save()
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
