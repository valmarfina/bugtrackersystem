# USER GUIDE bugtrackersystem

1. Добавлять никаких юзеров заранее не нужно, досточно создать бд используя CFbugtrackingdb.sql
2. Стартовая страница index.cfm
3. Запускаем приложение и регистрируемся в системе:
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/5987e32b-af21-4a43-8ca4-e1aa09c50f9d)
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/a64a11ce-df93-459f-80f3-78db0f551359)
4. После успешной регистрации Вас перебросит на страницу авторизации, авторизуемся в системе используя только что созданный username и password
5. После успешной авторизации Вы попадаете на страницу со всеми багами(у Вас она будет пустая, потому что еще никаких багов не создано)
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/9e4c7829-2ed4-4d9a-9d86-5d2679eedbd7)
6. Давайте создадим новый баг, используя кнопку ADD NEW BUG
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/8ea646a5-377e-448f-bd9d-b0a747e44d69)
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/4f7ed919-1580-40ce-91a3-316cbeca9d6f)
7. Проверяем добавился ли баг и видим, что баг успешно добавился в систему(ID ошибки = 15). Статус бага автоматически выставляется на New.
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/0441f0cf-cae7-48b5-b22e-5cfdaedb190a)
8. ID ошибки каждого бага является ссылкой на его обзор, давайте перейдем к нашему только что созданному багу. Под BUG №15 видем имя того кем был создан баг а ниже его описание и история. История остусвует так какх никакх изменений после создания не было
 ![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/cf0e7d4c-4ea6-4ab5-9369-bc100810ae66)
9. Давайте изменим что то в нашем баге, нажимаем на кнопку Изменить баг, перед нами открывается модальное окно, где мы можем изменить статус бага и написать коментарий. Следуя ЖЦ ошибки и тз, мы знаем что после статуса Новая идет статус Открытая, поэтому в выпадающем списке у нас только один вариант. Также действие после изменения стутса должно быть - Назначение
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/1a91f3ef-4e11-408b-89d1-a1a181dc3687)
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/7f49be5a-1501-4d50-9a32-5dd4f68c826f)
10. Мы добавили коментарий и изменили статус, также после обновления статуса у нас появилась первая история. Произведенное действие записано верно. Давайте попрробуем еще раз изменить статус.
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/d54e4620-a5e9-4636-82a6-da60f48eef43)
11. Давайте попрробуем еще раз изменить статус. Все равботает
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/e7a0ca77-f03d-45f4-8358-f7784cd11ef3)
12. Также можно перейти на страницу HISTORY, где отображается каждая история всех багов, от самых свежих
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/1c3e3643-efef-4008-9682-5d0e50f62cce)
13. При нажатии на свое имя и фамилию у нас появляется выпадающий список с дейсвиями: можем выйти из системы или изменить свои данные
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/a1ccdab8-2c64-4487-9791-47bea1a2bb73)
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/99452c1c-1203-4830-b46e-19a64fc5ad95)

# database ER diagram CFbugtrackingdb
![image](https://github.com/valmarfina/bugtrackersystem/assets/62747320/e504c0fc-5387-47db-b00b-3ef254ad6bab)

# Постскриптум...
..приложение требует `значительных` доработок...
