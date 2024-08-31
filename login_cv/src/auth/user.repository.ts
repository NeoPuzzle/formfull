import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Users } from "src/entities/user.entity";
import { Repository } from "typeorm";

@Injectable()
export class UsersRepository {
    constructor(
        @InjectRepository(Users)
        private userRepository: Repository<Users>
    ){}

    getUserByEmail(email: string) {
        return this.userRepository.findOneBy({email});
        
    }

    async addUser(user: Users) {
        const newUser = await this.userRepository.save(user);
        const dbUser = await this.userRepository.findOneBy({id: newUser.id});
        const { password, ...userNoPassword } = dbUser;
        return userNoPassword;
    }
}