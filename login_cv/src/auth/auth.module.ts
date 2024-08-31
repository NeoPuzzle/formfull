import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UsersRepository } from './user.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Users } from 'src/entities/user.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Users ])
  ],
  providers: [AuthService, UsersRepository],
  controllers: [AuthController]
})
export class AuthModule {}
