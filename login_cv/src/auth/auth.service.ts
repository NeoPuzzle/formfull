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
        try {
            if (!user) {
                console.error(`User with email ${email} not found`);
                throw new Error('invalid credentials');
            }
            console.log('password :', password);
            console.log('user.password: ', user.password);
            
            
            const isPasswordValid = await bcrypt.compare(password, user.password);
            if (!isPasswordValid) {
                console.error('Invalid credentials');
                throw new Error('Invalid credentials');
            }
            const payload = { email: user.email};
            return {
                access_token: this.jwtService.sign(payload)
            }
        } catch (error) {
            console.log('Login error: ', error);
            throw error;
        }
    }

}
