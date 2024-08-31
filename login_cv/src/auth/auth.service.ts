import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { User } from 'src/entities/user.entity';
import { compare, hash } from 'bcrypt';
import { Repository } from 'typeorm';
import { UsersRepository } from './user.repository';

@Injectable()
export class AuthService {
    constructor(
        private readonly jwtService: JwtService,
        private readonly userRepository: Repository<User>,
        private readonly usersRepository: UsersRepository,
    ){}

    async register(email: string, password: string): Promise<User> {
        const hashedPassword = await hash(password, 10);
        const user = new User();
        user.email = email;
        user.password = hashedPassword;
        return this.userRepository.save(user)
    }

    async login(email: string, password: string): Promise<{ access_token: string }> {
        const user = await this.usersRepository.getUserByEmail(email);
        if (!user || !(await compare(password, user.password))) {
            throw new Error('invalid credentials');
        }
        const payload = { email: user.email};
        return {
            access_token: this.jwtService.sign(payload)
        }
    }

}
