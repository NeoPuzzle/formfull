import { BadRequestException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UsersRepository } from './user.repository';
import { RegisterDto } from 'src/entities/auth.dto';

@Injectable()
export class AuthService {
    constructor(
        private readonly jwtService: JwtService,
        private readonly usersRepository: UsersRepository,
    ){}

    async register(user: RegisterDto) {
        const newUser = await this.usersRepository.getUserByEmail(user.email);
        if(newUser) throw new BadRequestException('User already exists');

        const hashedPassword = await bcrypt.hash(user.password, 10);
        if(!hashedPassword) throw new BadRequestException('Error hashing password');
        return await this.usersRepository.addUser({...user, password: hashedPassword})
    }

    async login(email: string, password: string): Promise<{ access_token: string }> {
        const user = await this.usersRepository.getUserByEmail(email);
        if (!user || !(await bcrypt.compare(password, user.password))) {
            throw new Error('invalid credentials');
        }
        const payload = { email: user.email};
        return {
            access_token: this.jwtService.sign(payload)
        }
    }

}
