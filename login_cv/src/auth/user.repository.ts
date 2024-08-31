import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { User } from "src/entities/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class UsersRepository {
    constructor(
        @InjectRepository(User)
        private userRepository: Repository<User>
    ){}

    getUserByEmail(email: string) {
        return this.userRepository.findOneBy({email});
        
    }
}